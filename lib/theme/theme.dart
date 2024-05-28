import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xfff9410a),
    onPrimary: Color(0xff19191a),
    secondary: Color(0xffeeeeee),
    onSecondary: Color(0xff585858),
    background: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xfff39c12),
      onPrimary: Colors.white,
      secondary: Color(0xff232323),
      onSecondary: Color(0xff585858),
      background: Color(0xff19191a),
    ));
