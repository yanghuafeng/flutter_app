import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/HomePage.dart';
import 'package:flutterapp/route/AnimationRouter.dart';
import 'package:flutterapp/route/ProviderRouter.dart';

import 'IRouterProvider.dart';

/**
 * Created by YHF at 17:05 on 2021-09-08.
 */
class MainRouter {

  static String home = "/home";

  //子router管理集合
  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(FluroRouter router) {

    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return Container(child: Text("未找到目标页"),);
        });

    router.define(home, handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) => HomePage()));


    //每次初始化前 先清除集合 以免重复添加
    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(AnimationRouter());
    _listRouter.add(ProviderRouter());


    /// 初始化路由 循环遍历取出每个子router进行初始化操作
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }
}