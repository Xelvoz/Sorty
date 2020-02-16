import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:sorty/screens/visualizer_screen.dart';

class Sorty extends StatelessWidget {
  Sorty();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sorty 〽️ - Sorting Algorithms Visualization",
      home: VisualizerScreen(),
    );
  }
}
