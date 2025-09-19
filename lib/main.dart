import 'package:algorithm_visualizer/pages/algorithms_page.dart';
import 'package:algorithm_visualizer/pages/home_page.dart';
import 'package:algorithm_visualizer/themes/dark_mode.dart';
import 'package:algorithm_visualizer/themes/light_mode.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const AlgoVisualizerApp());
}

class AlgoVisualizerApp extends StatelessWidget {
  const AlgoVisualizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Algorithm Visualizer',
      theme: lightMode,
      darkTheme: darkMode,
      home: const HomePage(),
    );
  }
}

