import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

class SelectionSort extends AbstractSorter {
  SelectionSort({
    ArrayGenerator arrayGenerator,
    Duration animationDelay,
  }) : super(
          name: "Selection Sort",
          arrayGenerator: arrayGenerator,
          animationDelay: animationDelay,
        );

  @override
  Future<void> sort() async {
    await _selectionSort();
    ArrayFeed.addUpdate(ArrayUpdates(array: array));
  }

  Future<void> _selectionSort() async {
    int n = array.length;

    // One by one move boundary of unsorted subarray
    for (int i = 0; i < n - 1; i++) {
      // Find the minimum element in unsorted array
      int min_idx = i;
      for (int j = i + 1; j < n; j++) if (array[j] < array[min_idx]) min_idx = j;

      // Swap the found minimum element with the first
      // element
      await Future.delayed(animationDelay, () => arrayGenerator.swap(min_idx, i));
      ArrayFeed.addUpdate(
        ArrayUpdates(
          array: array,
          highlightedNumbers: [array[min_idx], array[i]],
        ),
      );
    }
  }

  @override
  AbstractSorter copyWith({arrayGenerator, animationDelay}) {
    var _aniDelay = animationDelay ?? this.animationDelay.inMilliseconds;
    return SelectionSort(
      animationDelay: Duration(milliseconds: _aniDelay),
      arrayGenerator: arrayGenerator ?? this.arrayGenerator,
    );
  }
}
