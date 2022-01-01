import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenUtil {
  static ScreenUtil? _instance;

  static ScreenUtil get instance {
    _instance ??= ScreenUtil();

    return _instance!;
  }

  int width;
  int height;
  bool allowFontScaling;

  MediaQueryData? _mediaQueryData;
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _screenHeightNoPadding = 0;
  double _screenHeightNoPaddingNoAppbar = 0;
  double _pixelRatio = 0;
  double _statusBarHeight = 0;
  double _bottomBarHeight = 0;
  double _textScaleFactor = 0;
  Orientation _orientation = Orientation.portrait;

  ScreenUtil({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  }) {
    _init();
  }

  ScreenUtil getInstance() {
    return instance;
  }

  void _init() {
    MediaQueryData mediaQuery = Get.mediaQuery;
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
    _orientation = mediaQuery.orientation;
    _screenHeightNoPadding =
        mediaQuery.size.height - _statusBarHeight - _bottomBarHeight;
    _screenHeightNoPaddingNoAppbar =
        _screenHeightNoPadding - AppBar().preferredSize.height;
  }

  MediaQueryData get mediaQueryData => _mediaQueryData!;

  double get textScaleFactory => _textScaleFactor;

  double get pixelRatio => _pixelRatio;

  Orientation get orientation => _orientation;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get screenWidthPx => _screenWidth * _pixelRatio;

  double get screenHeightPx => _screenHeight * _pixelRatio;

  double get screenHeightNoPadding => _screenHeightNoPadding;

  double get screenHeightNoPaddingNoAppbar => _screenHeightNoPaddingNoAppbar;

  double get statusBarHeight => _statusBarHeight * _pixelRatio;

  double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;

  double get screenWidth80Percent => _screenWidth * 0.8;

  setWidth(int width) => width * scaleWidth;

  setHeight(int height) => height * scaleHeight;

  setSp(int fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}
