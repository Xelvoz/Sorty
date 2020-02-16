import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sorty/visualizers/abstract_visualizer.dart';

class RGBCircleVisualizer extends AbstractVisualizer {
  final List<int> array;
  final List<int> highlights;
  final List<int> specialHighlights;
  final Paint _paint = Paint();

  RGBCircleVisualizer({
    this.array,
    this.highlights,
    this.specialHighlights,
  }) : super(array: array, highlights: highlights, specialHighlights: specialHighlights);

  @override
  void drawNumber(Canvas canvas, Size size, int number, int position) {
    double radius = (size.height - 20) / 2;
    Offset origin = Offset(size.width / 2, size.height / 2);
    double theta = position / array.length;
    double thetaPrevious = (position == array.length - 1) ? 0 : (position + 1) / array.length;
    double x = origin.dx + radius * cos(2 * pi * theta);
    double y = origin.dy + radius * sin(2 * pi * theta);
    double xPrevious = origin.dx + radius * cos(2 * pi * thetaPrevious);
    double yPrevious = origin.dy + radius * sin(2 * pi * thetaPrevious);

    canvas.drawPath(
      Path()
        ..addPolygon([
          origin,
          Offset(x, y),
          Offset(xPrevious, yPrevious),
        ], true),
      _paint
        ..color = HSVColor.fromAHSV(1, (360 / array.length) * number, 1, 1).toColor()
        ..strokeWidth = 10
        ..style = PaintingStyle.fill,
    );
  }
}
