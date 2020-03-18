import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

class MergeSort extends AbstractSorter {
  MergeSort({
    ArrayGenerator arrayGenerator,
    Duration animationDelay,
  }) : super(
          name: "MergeSort",
          arrayGenerator: arrayGenerator,
          animationDelay: animationDelay,
        );

  @override
  Future<void> sort() async {
    await _mergeSort(0, array.length - 1);
    ArrayFeed.addUpdate(ArrayUpdates(array: array));
  }

  Future<void> merge(int l, int m, int r) async {
    // Find sizes of two subarrays to be merged
    int n1 = m - l + 1;
    int n2 = r - m;

    /* Create temp arrays */
    List<int> L = List(n1);
    List<int> R = List(n2);

    /*Copy data to temp arrays*/
    for (int i = 0; i < n1; ++i) L[i] = array[l + i];
    for (int j = 0; j < n2; ++j) R[j] = array[m + 1 + j];

    /* Merge the temp arrays */

    // Initial indexes of first and second subarrays
    int i = 0, j = 0;

    // Initial index of merged subarry array
    int k = l;
    while (i < n1 && j < n2) {
      int tmp = array[k];
      if (L[i] <= R[j]) {
        await Future.delayed(animationDelay, () {
          array[k] = L[i];
          i++;
        });
      } else {
        await Future.delayed(animationDelay, () {
          array[k] = R[j];
          j++;
        });
      }
      ArrayFeed.addUpdate(ArrayUpdates(
        array: array,
        highlightedNumbers: [array[k], tmp],
      ));

      k++;
    }

    /* Copy remaining elements of L[] if any */
    int tmp;
    while (i < n1) {
      tmp = array[k];
      await Future.delayed(animationDelay, () {
        array[k] = L[i];
      });
      ArrayFeed.addUpdate(ArrayUpdates(
        array: array,
        specialHighlitedNumbers: [array[k], tmp],
      ));
      i++;
      k++;
    }

    /* Copy remaining elements of R[] if any */
    while (j < n2) {
      tmp = array[k];
      await Future.delayed(animationDelay, () {
        array[k] = R[j];
      });
      ArrayFeed.addUpdate(ArrayUpdates(
        array: array,
        specialHighlitedNumbers: [array[k], tmp],
      ));
      j++;
      k++;
    }
  }

  // Main function that sorts arr[l..r] using
  // merge()
  Future<void> _mergeSort(int l, int r) async {
    if (l < r) {
      // Find the middle point
      int m = (l + r) ~/ 2;

      // Sort first and second halves
      await _mergeSort(l, m);
      await _mergeSort(m + 1, r);

      // Merge the sorted halves
      await merge(l, m, r);
    }
  }

  @override
  AbstractSorter copyWith({arrayGenerator, animationDelay}) {
    var _aniDelay = animationDelay ?? this.animationDelay.inMilliseconds;
    return MergeSort(
      animationDelay: Duration(milliseconds: _aniDelay),
      arrayGenerator: arrayGenerator ?? this.arrayGenerator,
    );
  }
}
