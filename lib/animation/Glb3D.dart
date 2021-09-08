/**
 * Created by YHF at 15:36 on 2021-09-08.
 */
import 'dart:async';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';
//import 'package:model_viewer/model_viewer.dart';


/* android 9+ need
<application
    android：name =“ io.flutter.app.FlutterApplication”
    android：label =“ flutter_model_viewer_demo”
    android：icon =“ @ mipmap / ic_launcher”
    android：usesCleartextTraffic =“ true”>
 */

class Glb3DPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Glb3DState();
  }
}

class Glb3DState extends State<Glb3DPage>{
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
                child:  Container(
                    margin: EdgeInsets.all(20.0),
                    width: 200,
                    height: 200,
                    child:
//                  ModelViewer(
//                    backgroundColor: Colors.teal[50],
//                    src: 'assets/structure.glb',
//                    alt: "A 3D model of an table soccer",
//                    autoPlay: true,
//                    autoRotate: true,
//                    cameraControls: true,
//                  ),
                    BabylonJSViewer(
                      src: 'assets/glb/structure.glb',
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}



