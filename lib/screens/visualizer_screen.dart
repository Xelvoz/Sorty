import 'package:flutter/material.dart';
import 'package:sorty/visualizers/bars_visualizer.dart';

class VisualizerScreen extends StatefulWidget {
  @override
  _VisualizerScreenState createState() => _VisualizerScreenState();
}

class _VisualizerScreenState extends State<VisualizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomPaint(
          painter: BarsVisualizer(),
        ),
      ),
    );
  }
}
