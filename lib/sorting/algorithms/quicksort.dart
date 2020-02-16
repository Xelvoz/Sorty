import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_generator.dart';

class Quicksort extends AbstractSorter {
  Quicksort({
    ArrayGenerator arrayGenerator,
  }) : super(name: "Quicksort", arrayGenerator: arrayGenerator);

  @override
  Future<void> sort() async {
    animationStatus.add(SortingStatus.INPROGRESS);
    await _quickSort(0, arrayGenerator.array.length - 1);
    animationStatus.add(SortingStatus.COMPLETED);
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
    var pivot = arrayGenerator.array[high];
    specialHighlitedNumbers.add(pivot);

    var i = (low - 1); // Index of smaller element

    for (int j = low; j <= high - 1; j++) {
      // If current element is smaller than the pivot
      if (arrayGenerator.array[j] < pivot) {
        i++; // increment index of smaller element
        highlightedNumbers.add(arrayGenerator.array[i]);
        highlightedNumbers.add(arrayGenerator.array[j]);
        await Future.delayed(animationDelay, () {
          arrayGenerator.swap(i, j);
        }).then((_) => addCurrentArrayToStream());
        highlightedNumbers.clear();
      }
    }

    highlightedNumbers.add(arrayGenerator.array[i + 1]);
    highlightedNumbers.add(arrayGenerator.array[high]);

    await Future.delayed(animationDelay, () {
      arrayGenerator.swap(i + 1, high);
    }).then((_) => addCurrentArrayToStream());
    highlightedNumbers.clear();
    specialHighlitedNumbers.clear();
    return (i + 1);
  }
}
