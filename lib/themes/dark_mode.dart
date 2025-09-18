import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(211, 45, 45, 45),
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade500,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[200],
    displayColor: Colors.white,
  ),
); 