import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ProviderNotes/WholeProviderTest.dart';
import 'package:flutterapp/carousel/CardItem.dart';
import 'package:flutterapp/carousel/CardItemInfo.dart';

/**
 * Created by YHF at 15:39 on 2021-11-19.
 */

class CardView extends StatefulWidget{

  double width;
  List<CardItemInfo> dataList;

  CardView(this.width,this.dataList);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> with SingleTickerProviderStateMixin{

  late double width;
  late AnimationController _controller;
  late Animation _animation;
  late List<CardItem> viewLst;

  @override
  void initState() {
    super.initState();
    width = widget.width;

    widget.dataList.asMap().forEach((index, info) {
      viewLst.add(new CardItem(index,Image.asset(info.pic!), (check){
        cardItemCheck(check);
      }));
    });

    _controller = AnimationController(vsync: this,duration: Duration(seconds: 5));
    _controller.addListener(() {
      setState(() {
      });
    });
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.dismissed){
        ;
      }
    });
    _animation = Tween(begin: 0,end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn)
    );

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      //_controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: width/1.5,
        child: Stack(
          children: [

          ],
        ),
      ),
    );
  }

  cardItemCheck(int index){
    //todo
  }
}