import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade400,
    secondary: Colors.grey.shade500,
    tertiary: const Color.fromARGB(255, 62, 61, 61),
    inversePrimary: Colors.grey.shade700,
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black,
  ),
); 