import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

/**
 * Created by YHF at 10:34 on 2021-10-20.
 */

class ThirdWebSocket{

  void connect()async{
    final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');



    Widget widget = StreamBuilder(//监听来自服务器的消息
      stream: channel.stream,
      builder: (context, snapshot) {
        return Text(snapshot.hasData ? '${snapshot.data}' : '');
      },
    );

    //发送信息
    channel.sink.add('Hello!');

    //关闭连接
    channel.sink.close();

  }

}