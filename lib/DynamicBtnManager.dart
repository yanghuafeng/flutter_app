import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import 'DynamicButton.dart';

/**
 * Created by YHF at 17:18 on 2021-05-20.
 */

class DynamicBtnManager{
  factory DynamicBtnManager() => _getInstance()!;

  static DynamicBtnManager? get instance => _getInstance();
  static DynamicBtnManager? _instance;

  static DynamicBtnManager? _getInstance() {
    if (_instance == null) {
      _instance = new DynamicBtnManager._internal();
    }
    return _instance;
  }

  DynamicBtnManager._internal(){
  }

  final String resPath = "/plugin_run/res/";
  final String bottomPath = "/plugin_run/bottom_run/";
  final String gwResPath = ":9266/stb/run_res/res/";
  final String gwBottomCommon = ":9266/stb/run_res/bottom_run/bottom_run_common.json";
  String BUSI_CLUBHREF = "https://www.ktvme.com/Vroom/SongBanner/voddy?kpm_channel=30010203";

  late Directory _dir;
  late DynamicButton button;
  late ImgIcon icon;
  late String gwip;
  bool _hasButton = false;
  String? _imagePath;
  Widget imgWidget = new SizedBox();
  String? companyCode;
  ReceivePort receivePort = new ReceivePort();
  static String dataTransport = "DataTransport";

  String? downloadButtonId;
  String? downloadSrcIdH;
  String? downloadSrcIdV;


  String? get imagePath => _imagePath;

  set imagePath(String? value) {
    _imagePath = value;
  }

  bool get hasButton => _hasButton;

  set hasButton(bool value) {
    _hasButton = value;
  }

  init()async{
    _dir = await getApplicationDocumentsDirectory();
    FlutterDownloader.initialize();
    Directory directory = Directory(_dir.path+bottomPath);
    if(directory.existsSync()){
      directory.deleteSync(recursive: true);
    }
    await directory.create(recursive: true);
    Directory directory2 = Directory(_dir.path+resPath);
    if(directory2.existsSync()){
      directory2.deleteSync(recursive: true);
    }
    directory2.create(recursive: true);

    gwip = "192.168.82.52";
    IsolateNameServer.registerPortWithName(receivePort.sendPort, dataTransport);
    receivePort.listen((message)async{
      String? id = message[0];
      DownloadTaskStatus? status = message[1];
      int? progress = message[2];
      if(status == DownloadTaskStatus.complete){
        if(id == downloadButtonId){
          File file = new File(_dir.path + bottomPath + "bottom_run_common.json");
          file.exists().then((value) => print("DynamicBtnManager: download bottom_run_common.json :$value"));
          String content = await file.readAsString();
          print("DynamicBtn: bottom_run_common content:" + content);
          try{
            button = new DynamicButton.fromJson(json.decode(content));
          }catch (e){
            print("DynamicBtn: button parse error" + e.toString());
            return;
          }
          if(button.common!.isNotEmpty && button.common![0]!.icon!.isNotEmpty){
            icon = button.common![0]!.icon![0]!;
            hasButton = true;
            downloadSrcIdH = await downloadFile("http://" + gwip + gwResPath + icon.h_src!, _dir.path + resPath);
            downloadSrcIdV = await downloadFile("http://" + gwip + gwResPath + icon.v_src!, _dir.path + resPath);
          }
        }else if(id == downloadSrcIdH){
          File fileH = new File(_dir.path + resPath + icon.h_src!);
          if (fileH.existsSync()) {
            imgWidget = Image.file(fileH, fit: BoxFit.contain, height: 446);
          }
        }else if(id == downloadSrcIdV){
          File fileV = new File(_dir.path + resPath + icon.v_src!);
          if (fileV.existsSync()) {
            imgWidget = Image.file(fileV, fit: BoxFit.contain, height: 446);
          }
        }
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);

    downloadButtonId = await downloadFile("http://"+gwip+gwBottomCommon,_dir.path+bottomPath);
  }

  static void downloadCallback(id, status, progress)async{
    SendPort sendPort = IsolateNameServer.lookupPortByName(dataTransport)!;
    sendPort.send([id,status,progress]);
  }

  Future<String?>downloadFile(downloadUrl, savePath) async {
    return await FlutterDownloader.enqueue(
        url: downloadUrl,
        savedDir: savePath,
        showNotification: false,
        openFileFromNotification:false
    );
  }

}