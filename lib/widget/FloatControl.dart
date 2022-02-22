import 'package:flutter/material.dart';

/**
 * Created by YHF at 14:58 on 2021-12-15.
 */

class FloatControl{
  static OverlayEntry? _holder;

  static late Widget view;

  static void remove() {
    if (_holder != null) {
      _holder?.remove();
      _holder = null;
    }
  }

  static void show(BuildContext context,  Widget view) {
    FloatControl.view = view;

    remove();
    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      return new Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          child: _buildDraggable(context));
    });

    //往Overlay中插入插入OverlayEntry
    Overlay.of(context)?.insert(overlayEntry);

    _holder = overlayEntry;
  }


  static _buildDraggable(context) {
    return  dragWidget(context);
  }

  static Widget dragWidget(BuildContext context){
    return new Draggable(
      child: view,
      feedback: view,
      onDragEnd: (detail) {
        createDragTarget(detail.offset, context);
      },
      maxSimultaneousDrags: 1,
      childWhenDragging: Container(),
    );
  }


  static void refresh() {
    _holder?.markNeedsBuild();
  }

  static void createDragTarget(Offset offset, BuildContext context) {
    if (_holder != null) {
      _holder?.remove();
    }
    _holder = new OverlayEntry(builder: (context) {
      bool isLeft = true;
      if (offset.dx + 100 > MediaQuery.of(context).size.width / 2) {
        isLeft = false;
      }
      double maxY = MediaQuery.of(context).size.height - 100;
      return new Positioned(
          top: offset.dy < 50 ? 50 : offset.dy < maxY ? offset.dy : maxY,
          left: isLeft ? 0 : null,
          right: isLeft ? null : 0,
          child: dragWidget(context));
    });

    if(_holder!=null) {
      Overlay.of(context)?.insert(_holder!);
    }
  }
}