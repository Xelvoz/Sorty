import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

class Quicksort extends AbstractSorter {
  Quicksort({
    ArrayGenerator arrayGenerator,
    Duration animationDelay,
  }) : super(
          name: "Quicksort",
          arrayGenerator: arrayGenerator,
          animationDelay: animationDelay,
        );

  @override
  Future<void> sort() async {
    await _quickSort(0, array.length - 1);
    ArrayFeed.addUpdate(ArrayUpdates(array: array));
  }

  Future<void> _quickSort(int low, int high) async {
    if (low < high) {
      var pi = await partition(low, high);

      await _quickSort(low, pi - 1); // Before pi
      await _quickSort(pi + 1, high); // After pi
    }
  }

  Future<int> partition(int low, int high) async {
    // pivot (Element to be placed at right position)
    var pivot = array[high];

    var i = (low - 1); // Index of smaller element

    for (int j = low; j <= high - 1; j++) {
      // If current element is smaller than the pivot
      if (array[j] < pivot) {
        i++; // increment index of smaller element
        await Future.delayed(animationDelay, () {
          arrayGenerator.swap(i, j);
        }).then(
          (_) => ArrayFeed.addUpdate(ArrayUpdates(
            array: array,
            highlightedNumbers: [
              array[i],
              array[j],
            ],
            specialHighlitedNumbers: [pivot],
          )),
        );
      }
    }

    await Future.delayed(animationDelay, () {
      arrayGenerator.swap(i + 1, high);
    }).then(
      (_) => ArrayFeed.addUpdate(ArrayUpdates(
        array: array,
        highlightedNumbers: [
          array[i + 1],
          array[high],
        ],
      )),
    );
    return (i + 1);
  }

  @override
  AbstractSorter copyWith({arrayGenerator, animationDelay}) {
    var _aniDelay = animationDelay ?? this.animationDelay.inMilliseconds;
    return Quicksort(
      animationDelay: Duration(milliseconds: _aniDelay),
      arrayGenerator: arrayGenerator ?? this.arrayGenerator,
    );
  }
}
