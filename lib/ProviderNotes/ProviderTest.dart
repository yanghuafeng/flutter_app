
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Created by YHF at 16:17 on 2021-09-15.
 */

class ProviderTest extends StatelessWidget{
  MenuCartNum provider = new MenuCartNum(0);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: (){
              Random ran = new Random();
              int a = ran.nextInt(20);
              provider.setNum(a);
              print(provider.num.toString());
            },
            child: Container(
              width: 50,
              height: 30,
              color: Colors.green,
            ),
          ),
          ChangeNotifierProvider(
            create: (_)=>provider,
            child: Consumer<MenuCartNum>(
              builder: (BuildContext context,
                  MenuCartNum value, Widget? child){
                return Text(provider.num.toString(),style: TextStyle(fontSize: 24),);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCartNum with ChangeNotifier{
  int _num;
  int get num => _num;

  MenuCartNum(this._num);

  void setNum(int number) {
    _num = number;
     notifyListeners();
  }
}