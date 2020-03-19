import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

class BubbleSort extends AbstractSorter {
  BubbleSort({
    ArrayGenerator arrayGenerator,
    Duration animationDelay,
  }) : super(
          name: "Bubble Sort",
          arrayGenerator: arrayGenerator,
          animationDelay: animationDelay,
        );

  @override
  Future<void> sort() async {
    await _bubbleSort();
    ArrayFeed.addUpdate(ArrayUpdates(array: array));
  }

  Future<void> _bubbleSort() async {
    int n = array.length;

    for (int i = 0; i < n - 1; i++)
      for (int j = 0; j < n - i - 1; j++)
        if (array[j] > array[j + 1]) {
          // swap arr[j+1] and arr[i]
          await Future.delayed(animationDelay, () => arrayGenerator.swap(j, j + 1));
          ArrayFeed.addUpdate(
            ArrayUpdates(
              array: array,
              highlightedNumbers: [array[j], array[j + 1]],
            ),
          );
        }
  }

  @override
  AbstractSorter copyWith({arrayGenerator, animationDelay}) {
    var _aniDelay = animationDelay ?? this.animationDelay.inMilliseconds;
    return BubbleSort(
      animationDelay: Duration(milliseconds: _aniDelay),
      arrayGenerator: arrayGenerator ?? this.arrayGenerator,
    );
  }
}
