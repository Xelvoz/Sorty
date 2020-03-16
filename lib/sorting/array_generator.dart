import 'package:flutter/material.dart';

class ArrayGenerator {
  int elements;
  List<int> array;
  RangeValues shuffleRange;

  ArrayGenerator(this.elements, {this.shuffleRange}) {
    array = List.from(initialArray);
    this.shuffleRange = shuffleRange ?? RangeValues(0, elements - 1.0);
  }

  ArrayGenerator copyWith({elements, shuffleRange}) {
    return ArrayGenerator(
      elements ?? this.elements,
      shuffleRange: shuffleRange ?? RangeValues(0, (elements ?? this.elements) - 1.0),
    );
  }

  List<int> get initialArray => List.generate(elements, (i) => i + 1);

  void shuffle() {
    int start = shuffleRange.start.toInt();
    int end = shuffleRange.end.toInt();
    assert(start >= 0 && end <= array.length - 1);
    var shuffledRange = array.skip(start).take(end - start).toList();
    shuffledRange.shuffle();
    array.replaceRange(start, end, shuffledRange);
  }

  void reset() {
    array = List.from(initialArray);
  }

  void swap(int i, int j) {
    int tmp = array[i];
    array[i] = array[j];
    array[j] = tmp;
  }
}
