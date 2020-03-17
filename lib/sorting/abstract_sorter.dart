import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

abstract class AbstractSorter {
  final String name;
  final ArrayGenerator arrayGenerator;
  Duration animationDelay;

  AbstractSorter({
    @required this.name,
    @required this.arrayGenerator,
    animationDelay,
  }) {
    this.animationDelay = animationDelay ?? const Duration(milliseconds: 50);
  }

  AbstractSorter copyWith({arrayGenerator, animationDelay});

  List<int> get array => arrayGenerator.array;

  List<int> get initialArray => arrayGenerator.initialArray;

  Future<void> sort();

  void reset() {
    arrayGenerator.reset();
  }

  void shuffle() {
    arrayGenerator.shuffle();
    ArrayFeed.addUpdate(ArrayUpdates(array: List.from(array)));
  }
}
