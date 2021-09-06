

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../ScreenAdaptor.dart';

/**
 * Created by YHF at 14:55 on 2021-09-03.
 */

class LogView extends StatefulWidget{
  WebSocket socket;
  LogView(this.socket);
  @override
  State<StatefulWidget> createState() {
    return LogViewState();
  }
}

class LogViewState extends State<LogView>{
  late WebSocket socket;
  List<String> list = [];
  ScrollController controller = new ScrollController();
  StreamSubscription? _streamSubscription;
  @override
  void initState() {
    super.initState();
    if(_streamSubscription!=null){
      _streamSubscription?.cancel();
      _streamSubscription = null;
    }
    initSocket();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_streamSubscription!=null){
      _streamSubscription?.cancel();
      _streamSubscription=null;
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          controller: controller,
          padding: EdgeInsets.only(bottom: Scr.px(100)),
          itemBuilder: (context,index){
            return Container(
              width: double.infinity,
              child: Text(list[index],
                style: TextStyle(
                  fontSize: Scr.font(24),
                  color: Colors.black,
                  decoration: TextDecoration.none
                ),
              ),
            );
          }),
    );
  }

  initSocket()async{
    socket = socket = await WebSocket.connect('ws://' + "192.168.74.86" +
        ':8090/log');
    _streamSubscription = socket.listen((event) {
      list.add(event.toString());
      if(list.length>3000){
        list.removeRange(0, 1500);
      }
      if(mounted) {
        setState(() {
        });
        Future.delayed(Duration(milliseconds: 100)).then((value) {
          controller.jumpTo(controller.position.maxScrollExtent);
        });
      }
    });
  }
}