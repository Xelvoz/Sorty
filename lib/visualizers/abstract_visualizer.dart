import 'package:flutter/cupertino.dart';
import 'package:sorty/sorting/abstract_sorter.dart';

abstract class AbstractVisualizer extends CustomPainter {
  final AbstractSorter sorter;

  AbstractVisualizer({this.sorter});

  void drawNumber(Canvas canvas, Size size, int number);

  @override
  void paint(Canvas canvas, Size size) {
    for (int elem in sorter.arrayGenerator.array) {
      drawNumber(canvas, size, elem);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
