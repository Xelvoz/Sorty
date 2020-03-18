import 'package:flutter/material.dart';
import 'package:sorty/sorting/array_feed.dart';

class VisualizationPaint extends StatefulWidget {
  List<int> initialArray;
  Function visualizer;

  VisualizationPaint({this.initialArray, this.visualizer});

  @override
  _VisualizationPaintState createState() => _VisualizationPaintState();
}

class _VisualizationPaintState extends State<VisualizationPaint> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArrayUpdates>(
        initialData: ArrayUpdates(array: widget.initialArray),
        stream: ArrayFeed.stream,
        builder: (context, snapshot) {
          return RepaintBoundary(
            child: CustomPaint(
              willChange: true,
              isComplex: false,
              painter: widget.visualizer(
                array: snapshot?.data?.array,
                highlights: snapshot?.data?.highlightedNumbers,
                specialHighlights: snapshot?.data?.specialHighlitedNumbers,
              ),
            ),
          );
        });
  }
}
