/**
 * Created by YHF at 17:07 on 2021-09-08.
 */


import 'package:flutter/material.dart';
import 'package:flutterapp/route/AnimationRouter.dart';
import 'package:flutterapp/route/NavigatorUtils.dart';

import 'HandWrittenBoard.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 500,
        child: Center(
          child: TextButton(
            onPressed: (){
            },
            child: SizedBox(),
          ),
        ),
      )
    );
  }



}



