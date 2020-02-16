import 'package:flutter/cupertino.dart';
import 'package:sorty/visualizers/bars_visualizer.dart';
import 'package:sorty/visualizers/rbgcircle_visualizer.dart';
import 'package:sorty/visualizers/spiral_visualizer.dart';

abstract class AbstractVisualizer extends CustomPainter {
  final List<int> array;
  final List<int> highlights;
  final List<int> specialHighlights;

  AbstractVisualizer({this.array, this.highlights, this.specialHighlights});

  factory AbstractVisualizer.bars({
    array,
    highlights,
    specialHighlights,
  }) =>
      BarsVisualizer(
        array: array,
        highlights: highlights,
        specialHighlights: specialHighlights,
      );

  factory AbstractVisualizer.rgbCircle({
    array,
    highlights,
    specialHighlights,
  }) =>
      RGBCircleVisualizer(
        array: array,
        highlights: highlights,
        specialHighlights: specialHighlights,
      );

  factory AbstractVisualizer.spiral({
    array,
    highlights,
    specialHighlights,
  }) =>
      SpiralVisualizer(
        array: array,
        highlights: highlights,
        specialHighlights: specialHighlights,
      );

  void drawNumber(Canvas canvas, Size size, int number, int position);

  @override
  void paint(Canvas canvas, Size size) {
    int pos = 0;
    for (int elem in array) {
      drawNumber(canvas, size, elem, pos);
      pos += 1;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
