import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/visualizers/abstract_visualizer.dart';

class BarsVisualizer extends AbstractVisualizer {
  final AbstractSorter sorter;
  final Paint _paint = Paint();

  double _horizontalOffset;
  double barThinkness;

  BarsVisualizer({this.sorter}) : super(sorter: sorter);

  @override
  void drawNumber(Canvas canvas, Size size, int number) {
    barThinkness = barThinkness ?? (sorter.arrayGenerator.array.length / size.width) - 1;
    _horizontalOffset = _horizontalOffset ?? barThinkness / 2;

    canvas.drawLine(
      Offset(_horizontalOffset, size.height),
      Offset(_horizontalOffset, (sorter.arrayGenerator.array.length / size.height) * number),
      _paint
        ..strokeWidth = barThinkness
        ..color = Colors.grey,
    );
    _horizontalOffset += barThinkness;
  }
}
