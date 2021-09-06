
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/SocketPage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'FlowDemo.dart';
import 'FlutterJs.dart';


Future<void> main() async{
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack!);//framework错误
  };
  runZoned<Future<Null>>(()async{
    runApp(MyApp());
    },onError: (error, stackTrace)  {//应用代码异常
    print("yyy"+error.toString());
    print("yyy"+stackTrace.toString());
  });
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
      //去掉右上角的debug贴纸
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red, //listView滑动到边缘颜色
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Center(
        child: Container(
          color: Colors.red,
          width: 250,
          height: 250,
          child: Builder(
            builder: (con){
              return TextButton(
                onPressed: (){
                  Navigator.of(con).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){
                    return FlowDemo();
                  }));
                },
                child: Icon(Icons.camera,size: 50,),
              );
            },
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



