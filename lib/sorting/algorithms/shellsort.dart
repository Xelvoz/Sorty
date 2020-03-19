import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

class ShellSort extends AbstractSorter {
  ShellSort({
    ArrayGenerator arrayGenerator,
    Duration animationDelay,
  }) : super(
          name: "Shell Sort",
          arrayGenerator: arrayGenerator,
          animationDelay: animationDelay,
        );

  @override
  Future<void> sort() async {
    await _shellSort();
    ArrayFeed.addUpdate(ArrayUpdates(array: array));
  }

  Future<void> _shellSort() async {
    int n = array.length;
    for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
      // Do a gapped insertion sort for this gap size.
      // The first gap elements a[0..gap-1] are already
      // in gapped order keep adding one more element
      // until the entire array is gap sorted
      for (int i = gap; i < n; i += 1) {
        // add a[i] to the elements that have been gap
        // sorted save a[i] in temp and make a hole at
        // position i
        int temp = array[i];

        // shift earlier gap-sorted elements up until
        // the correct location for a[i] is found
        int j;
        for (j = i; j >= gap && array[j - gap] > temp; j -= gap) {
          ArrayFeed.addUpdate(
            ArrayUpdates(array: array, highlightedNumbers: [array[j], array[j - gap]]),
          );
          await Future.delayed(animationDelay, () => array[j] = array[j - gap]);
        }

        // put temp (the original a[i]) in its correct
        // location
        ArrayFeed.addUpdate(
          ArrayUpdates(array: array, highlightedNumbers: [array[j], temp]),
        );
        await Future.delayed(animationDelay, () => array[j] = temp);
      }
    }
  }

  @override
  AbstractSorter copyWith({arrayGenerator, animationDelay}) {
    var _aniDelay = animationDelay ?? this.animationDelay.inMilliseconds;
    return ShellSort(
      animationDelay: Duration(milliseconds: _aniDelay),
      arrayGenerator: arrayGenerator ?? this.arrayGenerator,
    );
  }
}
