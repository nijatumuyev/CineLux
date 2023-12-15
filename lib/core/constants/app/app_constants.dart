import 'package:flutter/material.dart';

class Constants {
  static Constants? _instance;
  static Constants? get instance {
    _instance ??= Constants._init();
    return _instance;
  }

  Constants._init();

  static double? screenHeight;
  static double? screenWidth;
  static ColorScheme? myColorScheme;
  static TextTheme? myTextTheme;

  void getData(BuildContext context) {
    Constants.screenHeight = MediaQuery.of(context).size.height;
    Constants.screenWidth = MediaQuery.of(context).size.width;
    Constants.myColorScheme = Theme.of(context).colorScheme;
    Constants.myTextTheme = Theme.of(context).textTheme;
  }

  static const String langAssetPath = "assets/language";

  static RegExp emailValidator = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
}
