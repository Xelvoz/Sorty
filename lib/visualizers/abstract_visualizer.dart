import 'package:flutter/material.dart';

abstract class AbstractVisualizer extends CustomPainter {
  final List<int> array;
  final List<int> highlights;
  final List<int> specialHighlights;

  AbstractVisualizer({this.array, this.highlights, this.specialHighlights});

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
