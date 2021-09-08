/**
 * Created by YHF at 14:33 on 2021-09-08.
 */

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiAni extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ConfettiAniState();
  }
}

class ConfettiAniState extends State<ConfettiAni>{

  late ConfettiController controllerTopCenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initController();
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Icon(Icons.print,size: 30,color: Colors.white,)
              ],
            ),
          ),
          buildConfettiWidget(controllerTopCenter,180),
          buildButton()
        ],
      ),
    );
  }
  Align buildButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: RaisedButton(
          onPressed: () {
            controllerTopCenter.play();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          color: Colors.red,
          textColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }


  void initController() {
    controllerTopCenter = ConfettiController(duration: const Duration(seconds: 2));
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        maximumSize: Size(30, 30),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.directional,
        maxBlastForce: 20, // set a lower max blast force
        minBlastForce: 8, // set a lower min blast force
        emissionFrequency: 1,
        gravity: 1,
      ),
    );
  }
}