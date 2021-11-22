import 'dart:async';
/**
 * Created by YHF at 14:55 on 2021-05-31.
 */

import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';

/* android 9+ need
<application
    android：name =“ io.flutter.app.FlutterApplication”
    android：label =“ flutter_model_viewer_demo”
    android：icon =“ @ mipmap / ic_launcher”
    android：usesCleartextTraffic =“ true”>
 */

class TestPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TestPageState();
  }
}

class TestPageState extends State<TestPage>{
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        alignment: Alignment.center,
        child: Container(
          width: 1280,
          height: 720,
          child: Stack(
            children: [
              Container(
                width: 1280,
                height: 720,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }

}



