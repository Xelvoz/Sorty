import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/algorithms/mergesort.dart';
import 'package:sorty/sorting/algorithms/quicksort.dart';

enum Algorithm { Quicksort, Mergesort }

class AlgorithmFactory {
  AlgorithmFactory._();

  static AbstractSorter visualizerFunctionFromType(Algorithm algorithm) {
    switch (algorithm) {
      case Algorithm.Quicksort:
        return Quicksort();
      case Algorithm.Mergesort:
      default:
        return MergeSort();
    }
  }
}
