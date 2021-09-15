import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Created by YHF at 16:31 on 2021-09-15.
 */
class OverallNum with ChangeNotifier{
  int? _num;
  int? get num => _num;
  int max;

  OverallNum(this._num,{this.max = 9999});

  void setNum(int number) {
    if(number>max){
      number=max;
    }
    _num = number;
    notifyListeners();
  }
}

class WholeProviderTest extends StatelessWidget{
  int a = 0;
  WholeProviderTest(this.a);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OverallNum>.value(
      value: OverallNum(10,max: 999),
      child: showWidget(a),
    );

  }
}

class showWidget extends StatelessWidget{
  int value = 0;
  showWidget(this.value);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: (){
              Random ran = new Random();
              int a = ran.nextInt(40);
              Provider.of<OverallNum>(context,listen: false).setNum(a);
            },
            child: Container(
              width: 50,
              height: 30,
              color: Colors.green,
              child: Text(value.toString(),style: TextStyle(fontSize: 15),),
            ),
          ),
          Text(Provider.of<OverallNum>(context).num.toString(),style: TextStyle(fontSize: 24),)
        ],
      )
    );
  }
}