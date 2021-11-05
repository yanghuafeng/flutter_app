
import 'dart:math';

import 'package:flutter/material.dart';

/**
 * Created by YHF at 16:01 on 2021-10-19.
 */

class ChessBoard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RepaintBoundary(//独立绘制，防止意外重绘
        child: CustomPaint(
          size: Size(300,300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter{

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    //画棋盘
    drawChessboard(canvas, rect);
    //画棋子
    drawPieces(canvas, rect);

  }


  void drawChessboard(Canvas canvas, Rect rect){
    var paint = new Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..color = Color(0xFFDCC48C);

    canvas.drawRect(rect, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black38
      ..strokeWidth = 1.0;

    //画横线
    for (int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }

  //画棋子
  void drawPieces(Canvas canvas, Rect rect) {
    double eWidth = rect.width / 15;
    double eHeight = rect.height / 15;
    //画一个黑子
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    //画一个黑子
    canvas.drawCircle(
      Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }
}