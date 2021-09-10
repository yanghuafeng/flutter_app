
import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage.dart';
import 'package:flutterapp/TestPage.dart';
import 'package:flutterapp/animation/ConfettiAni.dart';
import 'package:flutterapp/route/AnimationRouter.dart';
import 'package:flutterapp/route/MainRouter.dart';
import 'package:flutterapp/route/NavigatorUtils.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Application.dart';
import 'animation/FlowDemo.dart';


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

final EaseObserver observer = EaseObserver();

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
    //创建一个Router对象
    final router = FluroRouter();
    //配置Routes注册管理
    MainRouter.configureRoutes(router);
    //将生成的router给全局化
    Application.router = router;

    //getPermission();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //去掉右上角的debug贴纸
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red, //listView滑动到边缘颜色
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorObservers: [observer],
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }

  getPermission()async{
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
      print("5");
    }
    //打开应用设置
   // openAppSettings();
    print("6");
    bool isShown = await Permission.contacts.shouldShowRequestRationale;
    print(isShown);
  }
}

class EaseObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    if (route.settings.name != null) {
      print('did push' + route.settings.name!);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute!.settings.name != null &&
        previousRoute.settings.name == '/home') {
    }
    if (route.settings.name != null &&
        route.settings.name!.contains("/home?")) {

    }
    if (route.settings.name != null &&
        route.settings.name!.contains("/order/menu")) {
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    // Log.d('did pop' + route.settings.name,tag: this.toString());
  }
}




