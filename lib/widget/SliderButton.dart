import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_balloon_slider/flutter_balloon_slider.dart';


/**
 * Created by YHF at 17:21 on 2021-12-15.
 */

class SliderButton extends StatefulWidget{

  SliderButton();

  @override
  State<SliderButton> createState() => _CircleProgressButtonState();
}

class _CircleProgressButtonState extends State<SliderButton> {

  double value = 0.1;
  double _upperValue = 180;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 500,
            height: 200,
            child: BalloonSlider(
                value: value,
                onChanged: (value){
//                  setState(() {
//                    this.value = value;
//                  });
                },

              showRope: false,
              onChangeEnd: (value){
                  print("value:"+value.toString());
              },
                ),
          ),
          TextButton(onPressed: (){
            setState(() {
              value+=10;
            });
          }, child: Container(width: 50,height: 50,color: Colors.red,))
        ],
    );
  }


}