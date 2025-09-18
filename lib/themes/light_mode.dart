import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade200,
    //primary: const Color.fromARGB(188, 200, 230, 201),
    primary: const Color.fromARGB(180, 118, 220, 212),
    secondary: const Color.fromARGB(146, 151, 207, 255),
    tertiary: const Color.fromARGB(255, 32, 32, 32),
    inversePrimary: Colors.grey.shade700,
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black,
  ),
); 