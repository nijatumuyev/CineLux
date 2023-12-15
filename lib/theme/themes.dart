// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  fontFamily: "Montserrat",
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xffffffff),
    primary: Color(0xff989898),
    primaryContainer: Colors.red,
    secondaryContainer: Color(0xfff7bb99),
    inversePrimary: Color(0xff151515),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  fontFamily: "Montserrat",
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color(0xff000000),
    primary: const Color(0xfffe0000),
    secondary: Color(0xff1d1d1d),
    tertiary: Color(0xFFE4676D),
    inversePrimary: Color(0xff151515),
  ),
  textTheme: TextTheme(
    labelLarge: TextStyle(),
    labelMedium: TextStyle(
        fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
    labelSmall: TextStyle(),
    bodyLarge: TextStyle(
        fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
    bodySmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white),
    headlineLarge: TextStyle(
      fontSize: 35,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(),
    headlineSmall: TextStyle(),
  ),
);
