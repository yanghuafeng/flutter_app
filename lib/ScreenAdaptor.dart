/**
 * Created by YHF at 14:28 on 2021-09-03.
 */

import 'dart:ui';

import 'package:flutter/material.dart';

class Scr {

//设计稿的设备尺寸修改
  static double width = 1080;
  static double height = 1920;

  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double _pixelRatio = mediaQuery.devicePixelRatio;
  static double _screenWidth = mediaQuery.size.width;
  static double _screenHeight = mediaQuery.size.height;
  static double _statusBarHeight = mediaQuery.padding.top;
  static double _bottomBarHeight = mediaQuery.padding.bottom;
  static double _textScaleFactor = mediaQuery.textScaleFactor;



  static MediaQueryData get mediaQueryData => mediaQuery;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;

  ///设备的像素密度
  //static double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  static double get screenWidthDp => _screenWidth;

  ///当前设备高度 dp
  static double get screenHeightDp => _screenHeight;

  ///当前设备宽度 px
  static double get screenWidth => _screenWidth * _pixelRatio;

  ///当前设备高度 px
  static double get screenHeight => _screenHeight * _pixelRatio;

  ///状态栏高度 dp 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;

  ///底部安全区距离 dp
  static double get bottomBarHeight => _bottomBarHeight;

  ///实际的 dp 与设计稿 px 的比例
  static get scaleWidth => _screenWidth / width;
  static get scaleHeight => _screenHeight / height;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  static double px(double width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的 px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为 false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size
  ///accessibility settings. The default is false.
  static font(double fontSize) => px(fontSize);

}