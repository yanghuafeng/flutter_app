import 'dart:async';
/**
 * Created by YHF at 14:55 on 2021-05-31.
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'download/DynamicButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';


class TestPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TestPageState();
  }
}

class TestPageState extends State<TestPage>{
  WebViewController? controller;
  DateTime dateLast = DateTime.now();
  Timer? timer;

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
                child:  UnconstrainedBox(
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    width: 200,
                    height: 200,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                     // border: new Border.all(width: 1, color: Colors.black,),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue,
                            offset: Offset(6.0, 6.0), //阴影x轴偏移量
                            blurRadius: 50, //阴影模糊程度
                            spreadRadius: 10 //阴影扩散程度
                        )
                      ],
                    ),
                    child: SizedBox()//Shimmer.fromColors(child: Container(color: Colors.red,), baseColor: Colors.blue, highlightColor: Colors.purple),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}



