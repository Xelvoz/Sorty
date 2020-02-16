import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sorty/visualizers/abstract_visualizer.dart';

class BarsVisualizer extends AbstractVisualizer {
  final List<int> array;
  final List<int> highlights;
  final List<int> specialHighlights;
  final Paint _paint = Paint();

  double _horizontalOffset;
  double barThinkness;

  BarsVisualizer({
    this.array,
    this.highlights,
    this.specialHighlights,
  }) : super(array: array, highlights: highlights, specialHighlights: specialHighlights);

  @override
  void drawNumber(Canvas canvas, Size size, int number, int position) {
    barThinkness = barThinkness ?? (size.width / array.length);
    _horizontalOffset = _horizontalOffset ?? (barThinkness / 2);
    canvas.drawLine(
      Offset(size.width - _horizontalOffset, size.height),
      Offset(size.width - _horizontalOffset, (size.height / array.length) * (number - 1)),
      _paint
        ..strokeWidth = barThinkness
        ..color = (highlights.contains(number)
            ? Colors.red[300]
            : specialHighlights.contains(number) ? Colors.blue : Colors.grey),
    );
    _horizontalOffset += barThinkness;
  }
}
