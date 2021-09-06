import 'dart:math';

import 'package:flutter/material.dart';

class FlowDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FlowDemoState();
  }
}

class FlowDemoState extends State<FlowDemo> with SingleTickerProviderStateMixin{
  final sides = [60.0, 50.0, 40.0, 30.0,20.0,10.0,9.0,8.0,7.0,6.0];
  final colors = [Colors.red,Colors.yellow,Colors.blue,Colors.green,Colors.red,Colors.yellow,Colors.blue,Colors.green,Colors.red,Colors.yellow];

  late AnimationController controller;
  late Animation animaton;
  double rad = 0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 10),vsync: this)
      ..addListener(() {
        setState(() {
        });
      })..addStatusListener((status) {
        if(status == AnimationStatus.completed){
          controller.reverse();
        }else if(status == AnimationStatus.dismissed){
          controller.forward();
        }
      });

    animaton = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(curve: Curves.fastOutSlowIn,parent: controller));


    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.forward();

    });


  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flow(
        delegate: _Delegate(animaton.value),
        children: sides.map((e) => _buildItem(e)).toList(),
      ),
    );
  }

  Widget _buildItem(double e) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors[sides.indexOf(e)]
      ),
      width: 30,
      alignment: Alignment.center,
      height: 30,
     // color: colors[sides.indexOf(e)],
      child: Text('$e',style: TextStyle(fontSize: 10,decoration: TextDecoration.none),),
    );
  }
}

class _Delegate extends FlowDelegate {
  double rad;
  _Delegate(this.rad);

  @override
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    var count = context.childCount;
    var perRad = 2 * pi / count ;
    for (int i = 0; i < count; i++) {
      print(i);
      var cSizeX = context.getChildSize(i)!.width / 2;
      var cSizeY = context.getChildSize(i)!.height / 2;
      var offsetX = (radius - cSizeX)*rad * cos(i * perRad+ rad*pi*10) + radius;
      var offsetY = (radius - cSizeY)*rad * sin(i * perRad+ rad*pi*10) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }

}
