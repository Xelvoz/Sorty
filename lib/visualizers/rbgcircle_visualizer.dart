import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sorty/visualizers/abstract_visualizer.dart';

class RGBCircleVisualizer extends AbstractVisualizer {
  final List<int> array;
  final List<int> highlights;
  final List<int> specialHighlights;
  final Paint _paint = Paint();
  double thetaOffset;

  RGBCircleVisualizer({
    this.array,
    this.highlights,
    this.specialHighlights,
  }) : super(array: array, highlights: highlights, specialHighlights: specialHighlights) {
    thetaOffset = 0;
  }

  @override
  void drawNumber(Canvas canvas, Size size, int number, int position) {
    double radius = (size.height - 20) / 2;
    Offset origin = Offset(size.width / 2, size.height / 2);
    double theta = 2 * pi / array.length;

    canvas.drawArc(
      Rect.fromCircle(center: origin, radius: radius),
      thetaOffset,
      theta,
      true,
      _paint
        ..color = HSVColor.fromAHSV(1, (360 / array.length) * number, 1, 1).toColor()
        ..strokeWidth = 0.5
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.fill,
    );

    thetaOffset += theta;
  }
}
