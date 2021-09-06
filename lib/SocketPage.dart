import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'ScreenAdaptor.dart';


/**
 * Created by YHF at 11:07 on 2021-09-02.
 */

class SocketPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SocketPageState();
  }
}

class SocketPageState extends State<SocketPage>{
  HttpServer? server;
  WebSocket? socket;
  WebSocket? errSocket;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: Scr.px(500),
          height: Scr.px(500),
          alignment: Alignment.center,
          child: Material(
            child: Column(
              children: [
                Container(
                  child: InkWell(
                    onTap: (){
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                      child: Text("server"),
                    ),
                  ),
                ),
                Container(
                  child: InkWell(
                    onTap: (){
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.green,
                      child: Text("client"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );

  }

  initServer()async{
    if(server!=null){
      return;
    }

    server = await HttpServer.bind(await getIp(), 8090);
    server?.listen((HttpRequest req) async {
      if (req.uri.path == '/log') {
        socket = await WebSocketTransformer.upgrade(req);
      }else if(req.uri.path == '/err'){
        errSocket = await WebSocketTransformer.upgrade(req);
      }
    });

  }

  uninitServer()async{
    await socket?.close();
    await errSocket?.close();
    await server?.close(force: true);
    socket = null;
    errSocket = null;
    server = null;
  }

  getIp() async{
    List<NetworkInterface> a = await NetworkInterface.list();
    return a.first.addresses.first.address;
  }

}