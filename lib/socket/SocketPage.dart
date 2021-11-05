import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../ScreenAdaptor.dart';


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

  sendMessage(String s){
    //发送信息
    socket?.add(s);
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


  _request() async {
    //建立连接
    var socket = await Socket.connect("baidu.com", 80);
    //根据http协议，发送请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    await socket.flush(); //发送
    //读取返回内容，按照utf8解码为字符串
    String _response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return _response;
  }

}