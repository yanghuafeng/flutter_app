
import 'package:consumer/consumer.dart';
import 'package:flutter/material.dart';

/**
 * Created by YHF at 17:32 on 2021-12-17.
 */

var consumer = new Consumer(PlayStatus());
class PlayStatus{
  String? singerPic;
  String? songName;
  String? singerName;
  bool? play;
  bool? ori;
  bool? mute;
  int? num;
}

class PersonalControlBar extends StatefulWidget{
  @override
  State<PersonalControlBar> createState() => _PersonalControlBarState();
}

String path = "assets/images/";
class _PersonalControlBarState extends State<PersonalControlBar> with SingleTickerProviderStateMixin{

  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(vsync: this,duration: Duration(seconds: 2));
  }

  bool re = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 100,
      child:  TextButton(
        onPressed: (){
          controller.stop();
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset(5,5),
                blurRadius: 10, //阴影范围
                spreadRadius: 1, //阴影浓度
                color: Colors.black, //阴影颜色
              ),
            ],
          ),
          width:100,
          height: 100,
          child: RotationTransition(
            turns: controller,
            child: ClipOval(
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset(path+"control/cd_default.png",
                  fit: BoxFit.fill,),
              ),
            ),
          )
          ),
      ),
      );
  }
}

