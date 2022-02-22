import 'package:flutter/cupertino.dart';

/**
 * Created by YHF at 9:42 on 2022-01-25.
 */

class ProgressBar extends StatefulWidget{

  double height;//椭圆矩形宽高
  Function? callback;
  Function? intimeCallback;
  int max;
  int min;
  ProgressBarProvider? provider;

  ProgressBar({
    this.height=100,
    this.callback,
    this.max=10,
    this.min=0,
    this.provider,
    this.intimeCallback
  });
  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {

  late double height;
  late double y;
  int curvalue = 0;
  double thumbHeight = 20;


  @override
  void initState() {
    super.initState();
    y=0;
    height = widget.height;
    curvalue = widget.min;

    widget.provider?.setCallbakc((int value){
      if(mounted){
        if(value!=curvalue){
          curvalue = value;
          setPosition();
          setState(() {
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 5,
            height: height-10,
            child: Image.asset("assets/images/progressbar_nl.png"),
          ),
          Positioned(
            bottom: 5,
            child: Container(
              width: 1,
              height: y,
              child: Image.asset("assets/images/progressbar_hl.png",fit: BoxFit.fill,),
            ),
          ),
          Positioned(
              bottom: y,
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails s){
                    setState(() {
                      y = y - s.delta.dy;
                      if (y > height-thumbHeight) {
                        y = height-thumbHeight;
                      }
                      if(y<0){
                        y=0;
                      }
                    });
                    if(widget.intimeCallback!=null){
                      widget.intimeCallback!(getvalue());
                      print(getvalue());
                    }
                },
                onPanEnd: (DragEndDetails d){
                    curvalue = getvalue();
                    if(widget.callback!=null) {
                      widget.callback!(curvalue);
                      print("yyy"+getvalue().toString());
                    }

                },
                onTapDown: (TapDownDetails d){

                },
                onTapUp: (TapUpDetails d){

                },
                child: Container(
                  width: thumbHeight*20/43,
                  height: thumbHeight,
                  child: Image.asset("assets/images/progressbar_thumb.png"),
                ),
              )
          )
        ],
      ),
    );
  }

  int getvalue(){
    int max = widget.max;
    int min = widget.min;
    int value = (y/(height-thumbHeight)*(max-min)+min).toInt();
    if(value>max){
      value = max;
    }
    if(value<min){
      value = min;
    }

    return value;
  }

  setPosition(){
    int max = widget.max;
    int min = widget.min;
    if(curvalue>max){
      curvalue = max;
    }
    if(curvalue<min){
      curvalue = min;
    }
    y=((curvalue-min)/(max-min))*(height-thumbHeight);
  }

}

class ProgressBarProvider{
  Function? callback;

  void setCallbakc(Function function){
    callback = function;
  }
}