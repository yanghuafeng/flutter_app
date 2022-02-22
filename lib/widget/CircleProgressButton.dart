import 'dart:math';

import 'package:flutter/material.dart';


/**
 * Created by YHF at 17:21 on 2021-12-15.
 */

class CircleProgressButton extends StatefulWidget{
  double rectHeight = 290;//椭圆矩形宽高
  double rectWidth = 300;
  double linePadding = 3;//原点与边界的偏移
  Function callback;
  double? btnSize;
  Tween<int> tween;

  CircleProgressButton(this.rectHeight,this.rectWidth,this.linePadding,this.tween,this.callback,{this.btnSize});

  @override
  State<CircleProgressButton> createState() => _CircleProgressButtonState();
}

class _CircleProgressButtonState extends State<CircleProgressButton> {

  late double rectHeight;
  late double rectWidth;
  late double y;
  late double x;
  late double linePadding;

  @override
  void initState() {
    super.initState();
    rectHeight = widget.rectHeight;
    rectWidth = widget.rectWidth;
    linePadding = widget.linePadding;
    y=-rectHeight/2;
    x=0;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/circle_bg.png"),
          fit: BoxFit.fill
        )
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: y+rectHeight/2+linePadding,
            right: x,
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails s){
                setState(() {
                  y=y-s.delta.dy;
                  if(y<-rectHeight/2){
                    y=-rectHeight/2;
                  }
                  if(y>rectHeight/2){
                    y=rectHeight/2;
                  }
                  x = (rectWidth/rectHeight*sqrt((rectHeight*rectHeight/4-y*y).abs()));
                });
              },
              onPanEnd: (DragEndDetails d){
                print("CircleProgressButton return value: "+getvalue().toString());
                widget.callback(getvalue());
              },
              child: Container(
                  width: widget.btnSize??23,
                  height: widget.btnSize??23,
                  child: Image.asset("assets/images/circle_btn.png")),
            ),
          ),
        ],
      ),
    );
  }

  int getvalue(){
    int max = widget.tween.end??10;
    int min = widget.tween.begin??0;
    double valuey = y+rectHeight/2;
    int value = (valuey/rectHeight*(max-min)).toInt();
    if(value>max){
      value = max;
    }
    if(value<min){
      value = min;
    }

    return value;
  }

}