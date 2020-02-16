import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:sorty/sorting/array_generator.dart';

enum SortingStatus { IDLE, INPROGRESS, COMPLETED }

abstract class AbstractSorter {
  final String name;
  final Duration animationDelay;
  final List<int> highlightedNumbers = List();
  final List<int> specialHighlitedNumbers = List();
  final ArrayGenerator arrayGenerator;
  final StreamController<List<int>> arrayChangesStream = StreamController();
  final StreamController<SortingStatus> animationStatus = StreamController();

  AbstractSorter({
    @required this.name,
    this.animationDelay = const Duration(milliseconds: 50),
    @required this.arrayGenerator,
  });

  Stream<List<int>> get stream => arrayChangesStream.stream;
  List<int> get array => arrayGenerator.array;

  void addCurrentArrayToStream() {
    arrayChangesStream.add(List.from(arrayGenerator.array));
  }

  void closeStream() {
    arrayChangesStream.close();
    animationStatus.close();
  }

  Future<void> sort();

  void reset() {
    highlightedNumbers.clear();
    specialHighlitedNumbers.clear();
    arrayGenerator.reset();
  }

  void shuffleRange(int start, int end) {
    arrayGenerator.shuffleRange(start, end);
    arrayChangesStream.add(List.from(arrayGenerator.array));
  }

  void shuffleFrom(int start) {
    arrayGenerator.shuffleFrom(start);
    arrayChangesStream.add(List.from(arrayGenerator.array));
  }

  void shuffleUntil(int end) {
    arrayGenerator.shuffleUntil(end);
    arrayChangesStream.add(List.from(arrayGenerator.array));
  }

  void shuffle() {
    arrayGenerator.shuffle();
    arrayChangesStream.add(List.from(arrayGenerator.array));
  }
}
