import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

class InsertionSort extends AbstractSorter {
  InsertionSort({
    ArrayGenerator arrayGenerator,
    Duration animationDelay,
  }) : super(
          name: "Insertion Sort",
          arrayGenerator: arrayGenerator,
          animationDelay: animationDelay,
        );

  @override
  Future<void> sort() async {
    await _insertionSort();
    ArrayFeed.addUpdate(ArrayUpdates(array: array));
  }

  Future<void> _insertionSort() async {
    int n = array.length;

    for (int i = 1; i < n; ++i) {
      int key = array[i];
      int j = i - 1;

      /* Move elements of arr[0..i-1], that are 
               greater than key, to one position ahead 
               of their current position */
      while (j >= 0 && array[j] > key) {
        array[j + 1] = array[j];
        j = j - 1;
      }
      await Future.delayed(animationDelay, () => array[j + 1] = key);
      ArrayFeed.addUpdate(ArrayUpdates(
        array: array,
        highlightedNumbers: [array[i], array[j + 1]],
      ));
    }
  }

  static Future<void> sortArray(Duration animationDelay, List<int> arr) async {
    int n = arr.length;

    for (int i = 1; i < n; ++i) {
      int key = arr[i];
      int j = i - 1;

      /* Move elements of arr[0..i-1], that are 
               greater than key, to one position ahead 
               of their current position */
      while (j >= 0 && arr[j] > key) {
        arr[j + 1] = arr[j];
        j = j - 1;
      }

      await Future.delayed(animationDelay, () => arr[j + 1] = key);
      ArrayFeed.addUpdate(ArrayUpdates(
        array: arr,
        highlightedNumbers: [arr[i], arr[j + 1]],
      ));
    }
  }

  @override
  AbstractSorter copyWith({arrayGenerator, animationDelay}) {
    var _aniDelay = animationDelay ?? this.animationDelay.inMilliseconds;
    return InsertionSort(
      animationDelay: Duration(milliseconds: _aniDelay),
      arrayGenerator: arrayGenerator ?? this.arrayGenerator,
    );
  }
}
