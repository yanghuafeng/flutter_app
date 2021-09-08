import 'package:fluro/fluro.dart';
import 'package:flutterapp/animation/ConfettiAni.dart';
import 'package:flutterapp/animation/FlowDemo.dart';
import 'package:flutterapp/route/IRouterProvider.dart';

/**
 * Created by YHF at 16:59 on 2021-09-08.
 */

class AnimationRouter extends IRouterProvider{

  static String FlowPage = "/ani/flowPage";
  static String ConfettiPage = "/ani/confettiPage";


  @override
  void initRouter(FluroRouter router){
    router.define(FlowPage, handler: Handler(handlerFunc: (_,params){
      return FlowDemo();
    }));
    router.define(ConfettiPage, handler: Handler(handlerFunc: (_,params){
      return ConfettiAni();
    }));
  }
}