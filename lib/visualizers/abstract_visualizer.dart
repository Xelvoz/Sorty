import 'package:flutter/cupertino.dart';

abstract class AbstractVisualizer extends CustomPainter {
  final List<int> array;
  final List<int> highlights;
  final List<int> specialHighlights;

  AbstractVisualizer({this.array, this.highlights, this.specialHighlights});

  void drawNumber(Canvas canvas, Size size, int number);

  @override
  void paint(Canvas canvas, Size size) {
    for (int elem in array) {
      drawNumber(canvas, size, elem);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
