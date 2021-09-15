/**
 * Created by YHF at 15:53 on 2021-09-10.
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as UI;

class HandWrittenBoard extends StatefulWidget {
  ///手写笔颜色
  final Color? color;

  ///手写笔宽度
  final double? width;

  ///手写笔控制器
  final HandWrittenBoardController boardController;

  const HandWrittenBoard(
      {Key? key, this.color, this.width, required this.boardController})
      : super(key: key);

  @override
  _HandWrittenBoardState createState() => _HandWrittenBoardState();
}

class HandWrittenBoardController extends ChangeNotifier {
  late BuildContext _context;
  late List<Offset?> points = [];

  void bindContext(BuildContext context) {
    _context = context;
  }

  void refPoints(List<Offset?> newValue) {
    if (points != newValue) {
      points = newValue;
      notifyListeners();
    }
  }

  Future<UI.Image>? get uiImage {//截图
    UI.PictureRecorder recorder = UI.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    HandWrittenBoardPainter painter = HandWrittenBoardPainter(points);
    Size size = _context.size!;
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  void clearBoard() {
    points.clear();
    notifyListeners();
  }
}

class _HandWrittenBoardState extends State<HandWrittenBoard> {
  late ValueNotifier<List<Offset?>> _offsets = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    widget.boardController.bindContext(context);
  }

  void _onUpdate(DragUpdateDetails details) {
    RenderBox? _object = context.findRenderObject() as RenderBox;
    Offset _locationPoints = _object.globalToLocal(details.globalPosition);
    _offsets.value = new List.from(_offsets.value)..add(_locationPoints);
    _refPoints();
  }

  void _onEnd(DragEndDetails details) {
    _offsets.value.add(null);
    _refPoints();
  }

  void _refPoints() {
    widget.boardController.refPoints(_offsets.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onUpdate,
      onPanEnd: _onEnd,
      child: ValueListenableBuilder(
        valueListenable: _offsets,
        builder: (BuildContext context, List<Offset?> value, Widget? child) {
          return CustomPaint(
            painter: HandWrittenBoardPainter(value,
                color: widget.color, width: widget.width),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class HandWrittenBoardPainter extends CustomPainter {
  HandWrittenBoardPainter(this.points, {this.color, this.width});

  final List<Offset?> points;

  final Color? color;

  final double? width;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color ?? Colors.black
      ..strokeCap = StrokeCap.square
      ..strokeWidth = width ?? 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
