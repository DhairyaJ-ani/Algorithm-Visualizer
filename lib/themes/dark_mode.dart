import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 49, 49, 49),
    primary: const Color.fromARGB(255, 217, 119, 45),
    secondary: const Color.fromARGB(255, 0, 114, 106),
    tertiary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade500,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[200],
    displayColor: Colors.white,
  ),
); 