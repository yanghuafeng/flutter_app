
import 'package:flutter/material.dart';

/**
 * Created by YHF at 11:16 on 2021-11-19.
 */

class CardItem extends StatefulWidget{
  Widget view;
  Function onTap;
  int index;
  CardItem(this.index,this.view,this.onTap);
  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details){
        setState(() {
          check= true;
        });
      },
      onTapUp: (TapUpDetails details){
        setState(() {
          check = false;
        });
      },
      onPanDown: (DragDownDetails details){
        setState(() {
          check= true;
        });
      },
      onPanEnd: (DragEndDetails details){
        setState(() {
          check = false;
        });
      },
      onTap: (){
        widget.onTap(widget.index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: check?Colors.white:Colors.transparent,
            width: 1
          ),
          boxShadow: [
            BoxShadow(
              color: check?Colors.red:Colors.transparent,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ]
        ),
        child: widget.view,
      ),
    );
  }
}