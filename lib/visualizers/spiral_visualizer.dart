import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sorty/visualizers/abstract_visualizer.dart';

class SpiralVisualizer extends AbstractVisualizer {
  final List<int> array;
  final List<int> highlights;
  final List<int> specialHighlights;
  final Paint _paint = Paint();

  SpiralVisualizer({
    this.array,
    this.highlights,
    this.specialHighlights,
  }) : super(array: array, highlights: highlights, specialHighlights: specialHighlights);

  @override
  void drawNumber(Canvas canvas, Size size, int number, int position) {
    double radius = (size.height - 20) / 2;
    double numberRadius = (radius / array.length) * number;
    Offset origin = Offset(size.width / 2, size.height / 2);
    double theta = position / array.length;
    int coef = log(array.length) ~/ log(2);
    double x = origin.dx + numberRadius * cos(2 * coef * pi * theta);
    double y = origin.dy + numberRadius * sin(2 * coef * pi * theta);
    canvas.drawPoints(
        PointMode.points,
        [Offset(x, y)],
        _paint
          ..color = (highlights.contains(number)
              ? Colors.red[300].withAlpha(180)
              : specialHighlights.contains(number)
                  ? Colors.blue.withAlpha(180)
                  : Colors.grey.withAlpha(180))
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round);
  }
}
