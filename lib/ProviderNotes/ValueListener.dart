
import 'dart:math';

import 'package:flutter/material.dart';

/**
 * Created by YHF at 16:06 on 2021-09-15.
 */

class ValueListener extends StatelessWidget{

  ValueNotifier<String> name = new ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: (){
              Random ran = new Random();
              int a = ran.nextInt(10);
              name.value = a.toString();
            },
            child: Container(
              width: 50,
              height: 30,
              color: Colors.green,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: name,
            builder: (BuildContext context, String value, Widget? child){
              return Text(value,style: TextStyle(fontSize: 20),);
            },
          )
        ],
      ),
    );
  }
}