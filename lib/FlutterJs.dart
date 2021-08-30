/**
 * Created by YHF at 14:55 on 2021-05-31.
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/DynamicButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/StringParse.dart';


class MyApp1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyApp1State();
  }
}

class MyApp1State extends State<MyApp1>{
  late WebViewController controller;
  DateTime dateLast = DateTime.now();

  String url = "http://192.168.80.94:801/Vroom/SongBanner/voddy?kpm_channel=30010203&companycode=11980&barcode=11198007408651";

  @override
  void initState() {
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
              WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                javascriptChannels: <JavascriptChannel>[_jsChannel(),].toSet(),
                onWebViewCreated: (WebViewController mController){
                  controller = mController;
                },
                onPageFinished: (url){
                  print("finish: $url");
                },

                onPageStarted: (url){
                  print("start: $url");
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: (){
                    DateTime dateNow = DateTime.now();
                    if(dateNow.millisecondsSinceEpoch-dateLast.millisecondsSinceEpoch<500){
                      Navigator.pop(context);
                    }else{
                      _loadHtmlFromAssets();
                    }
                    dateLast = dateNow;
                  },
                  child: Container(
                    width: double.infinity,
                    height: 630,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async{
    //String fileHtmlContents = await rootBundle.loadString("assets/js.html");
    await controller.loadUrl(url);
  }


  // 创建 JavascriptChannel
  JavascriptChannel _jsChannel() => JavascriptChannel(
      name: 'flutterMethod',
      onMessageReceived: (JavascriptMessage message) {
        if(message.message=="finish"){
          Navigator.pop(context);
        }
      });

}



