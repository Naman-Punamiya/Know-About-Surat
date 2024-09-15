import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color(0xfff5ddc2),
    primary: Color(0xFFDC7633),
    secondary: Color(0xfffcf3cf),
    tertiary: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,
    primary: const Color(0xFFE6720B),
    secondary: Colors.grey.shade900,
    tertiary: Colors.white,
  )
);