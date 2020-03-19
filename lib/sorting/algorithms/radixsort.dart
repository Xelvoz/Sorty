import 'dart:math';

import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

class RadixSort extends AbstractSorter {
  RadixSort({
    ArrayGenerator arrayGenerator,
    Duration animationDelay,
  }) : super(
          name: "Radix Sort",
          arrayGenerator: arrayGenerator,
          animationDelay: animationDelay,
        );

  @override
  Future<void> sort() async {
    await _radixSort();
    ArrayFeed.addUpdate(ArrayUpdates(array: array));
  }

  Future<void> _radixSort() async {
    // Find the maximum number to know number of digits
    int m = array.reduce(max);

    // Do counting sort for every digit. Note that instead
    // of passing digit number, exp is passed. exp is 10^i
    // where i is current digit number
    for (int exp = 1; m ~/ exp > 0; exp *= 10) await _countSort(exp);
  }

  Future<void> _countSort(int exp) async {
    int n = array.length;
    List<int> output = List(n); // output array
    int i;
    List<int> count = List.filled(10, 0);

    // Store count of occurrences in count[]
    for (i = 0; i < n; i++) count[(array[i] ~/ exp) % 10]++;

    // Change count[i] so that count[i] now contains
    // actual position of this digit in output[]
    for (i = 1; i < 10; i++) count[i] += count[i - 1];

    // Build the output array
    for (i = n - 1; i >= 0; i--) {
      output[count[(array[i] ~/ exp) % 10] - 1] = array[i];
      count[(array[i] ~/ exp) % 10]--;
    }

    // Copy the output array to arr[], so that arr[] now
    // contains sorted numbers according to curent digit
    for (i = 0; i < n; i++) {
      ArrayFeed.addUpdate(ArrayUpdates(array: array, highlightedNumbers: [array[i], output[i]]));
      await Future.delayed(animationDelay, () => array[i] = output[i]);
    }
  }

  @override
  AbstractSorter copyWith({arrayGenerator, animationDelay}) {
    var _aniDelay = animationDelay ?? this.animationDelay.inMilliseconds;
    return RadixSort(
      animationDelay: Duration(milliseconds: _aniDelay),
      arrayGenerator: arrayGenerator ?? this.arrayGenerator,
    );
  }
}
