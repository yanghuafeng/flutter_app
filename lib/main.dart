import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/DynamicBtnManager.dart';
import 'package:flutterapp/DynamicButton.dart';
import 'package:flutterapp/FlutterJs.dart';
import 'package:flutterapp/TestPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:audioplayers/audioplayers.dart';

import 'AnimationTest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Center(
        child: Container(
          color: Colors.red,
          width: 250,
          height: 250,
          child: Builder(
            builder:(contexta){
              return FlatButton(
                onPressed: (){
                  getp();
//                  Navigator.of(contexta).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){
//                    return TestPage();
//                  }));
                },
                child: Icon(Icons.camera,size: 50,),
              );
            } ,
          )
        ),
      ),
    );
  }

  getp()async{
    var status = await Permission.camera.request();
    if (status.isGranted) {
      print("1");
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      print("2");

    }

    if (await Permission.contacts.request().isGranted) {
    // Either the permission was already granted before or the user just granted it.
    print("3");

    }

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    ].request();
    print(statuses[Permission.location]);

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    // Use location.
    print("4");

    }

    if (await Permission.speech.isPermanentlyDenied) {
    // The user opted to never again see the permission request dialog for this
    // app. The only way to change the permission's status now is to let the
    // user manually enable it in the system settings.
    openAppSettings();
    print("5");
    }
    openAppSettings();


    print("6");

    bool isShown = await Permission.contacts.shouldShowRequestRationale;
    print(isShown);
  }
}



