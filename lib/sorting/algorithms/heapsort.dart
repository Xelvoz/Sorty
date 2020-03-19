import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/sorting/array_generator.dart';

class HeapSort extends AbstractSorter {
  HeapSort({
    ArrayGenerator arrayGenerator,
    Duration animationDelay,
  }) : super(
          name: "Heap Sort",
          arrayGenerator: arrayGenerator,
          animationDelay: animationDelay,
        );

  @override
  Future<void> sort() async {
    await _heapSort();
    ArrayFeed.addUpdate(ArrayUpdates(array: array));
  }

  Future<void> _heapSort() async {
    int n = array.length;

    // Build heap (rearrange array)
    for (int i = (n ~/ 2) - 1; i >= 0; i--) await heapify(n, i);

    // One by one extract an element from heap
    for (int i = n - 1; i >= 0; i--) {
      // Move current root to end
      await Future.delayed(animationDelay, () => arrayGenerator.swap(0, i));
      ArrayFeed.addUpdate(ArrayUpdates(
        array: array,
        highlightedNumbers: [array[0], array[i]],
      ));
      // call max heapify on the reduced heap
      await heapify(i, 0);
    }
  }

  // To heapify a subtree rooted with node i which is
  // an index in arr[]. n is size of heap
  Future<void> heapify(int n, int i) async {
    int largest = i; // Initialize largest as root
    int l = 2 * i + 1; // left = 2*i + 1
    int r = 2 * i + 2; // right = 2*i + 2

    // If left child is larger than root
    if (l < n && array[l] > array[largest]) largest = l;

    // If right child is larger than largest so far
    if (r < n && array[r] > array[largest]) largest = r;

    // If largest is not root
    if (largest != i) {
      int halfDuration = animationDelay.inMilliseconds ~/ 4;
      await Future.delayed(
        Duration(milliseconds: halfDuration),
        () => arrayGenerator.swap(i, largest),
      );
      ArrayFeed.addUpdate(
        ArrayUpdates(
          array: array,
          specialHighlitedNumbers: [array[i], array[largest]],
        ),
      );
      // Recursively heapify the affected sub-tree
      await heapify(n, largest);
    }
  }

  @override
  AbstractSorter copyWith({arrayGenerator, animationDelay}) {
    var _aniDelay = animationDelay ?? this.animationDelay.inMilliseconds;
    return HeapSort(
      animationDelay: Duration(milliseconds: _aniDelay),
      arrayGenerator: arrayGenerator ?? this.arrayGenerator,
    );
  }
}
