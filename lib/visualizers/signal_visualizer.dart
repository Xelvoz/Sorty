import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sorty/visualizers/abstract_visualizer.dart';

class SignalVisualizer extends AbstractVisualizer {
  final List<int> array;
  List<double> signal;
  final List<int> highlights;
  final List<int> specialHighlights;
  final Paint _paint = Paint();

  double _halfHeight;
  double _portionHeight;
  double _unitWidth;

  SignalVisualizer({
    this.array,
    this.highlights,
    this.specialHighlights,
  }) : super(array: array, highlights: highlights, specialHighlights: specialHighlights) {
    signal = List.from(array).map((i) => sin(3 * i)).toList();
  }

  @override
  void drawNumber(Canvas canvas, Size size, int number, int position) {
    _halfHeight = _halfHeight ?? size.height / 2;
    _portionHeight = _portionHeight ?? size.height / 2.5;
    _unitWidth = _unitWidth ?? (size.width / array.length);
    if (position > 0)
      canvas.drawLine(
          Offset(
            _unitWidth * (position - 1),
            _halfHeight + _portionHeight * signal[position - 1],
          ),
          Offset(
            _unitWidth * position,
            _halfHeight + _portionHeight * signal[position],
          ),
          _paint
            ..strokeWidth = 1
            ..color = (highlights.contains(number)
                ? Colors.red[300]
                : specialHighlights.contains(number) ? Colors.blue : Colors.grey));
    canvas.drawPoints(
      PointMode.points,
      [
        Offset(
          _unitWidth * position,
          _halfHeight + _portionHeight * signal[position],
        ),
      ].toList(),
      _paint
        ..strokeWidth = 2
        ..color = Colors.white,
    );
  }
}
