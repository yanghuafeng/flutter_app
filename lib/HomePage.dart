/**
 * Created by YHF at 17:07 on 2021-09-08.
 */


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutterapp/TestPage.dart';
import 'package:flutterapp/carousel/CardItem.dart';
import 'package:flutterapp/personalWidget/ChessBoard.dart';
import 'package:flutterapp/personalWidget/RenderboxExam.dart';
import 'package:flutterapp/route/AnimationRouter.dart';
import 'package:flutterapp/route/NavigatorUtils.dart';
import 'package:flutterapp/route/ProviderRouter.dart';
import 'package:flutterapp/widget/CircleProgressButton.dart';
import 'package:flutterapp/widget/FloatControl.dart';
import 'package:flutterapp/widget/ProgressBar.dart';
import 'package:flutterapp/widget/SliderButton.dart';
import 'package:vector_math/vector_math_64.dart' as v;
import 'package:webview_flutter/webview_flutter.dart';


import 'HandWrittenBoard.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;
  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 10),);
    controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    animation = Tween<double>(begin: 0,end: 6*pi).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    controller.forward();

     SwiperControl control = new SwiperControl();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width:800,height:100,child: ProgressBar(height: 100,callback: (int a){},intimeCallback: (intb){},))
    );
  }

}



