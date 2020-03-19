import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/algorithms/bubblesort.dart';
import 'package:sorty/sorting/algorithms/heapsort.dart';
import 'package:sorty/sorting/algorithms/insertionsort.dart';
import 'package:sorty/sorting/algorithms/mergesort.dart';
import 'package:sorty/sorting/algorithms/quicksort.dart';
import 'package:sorty/sorting/algorithms/radixsort.dart';
import 'package:sorty/sorting/algorithms/selectionsort.dart';
import 'package:sorty/sorting/algorithms/shellsort.dart';

enum Algorithm {
  Quicksort,
  Mergesort,
  SelectionSort,
  BubbleSort,
  InsertionSort,
  HeapSort,
  RadixSort,
  ShellSort,
}

class AlgorithmFactory {
  AlgorithmFactory._();

  static AbstractSorter visualizerFunctionFromType(Algorithm algorithm) {
    switch (algorithm) {
      case Algorithm.Quicksort:
        return Quicksort();
      case Algorithm.SelectionSort:
        return SelectionSort();
      case Algorithm.BubbleSort:
        return BubbleSort();
      case Algorithm.InsertionSort:
        return InsertionSort();
      case Algorithm.HeapSort:
        return HeapSort();
      case Algorithm.RadixSort:
        return RadixSort();
      case Algorithm.ShellSort:
        return ShellSort();
      case Algorithm.Mergesort:
      default:
        return MergeSort();
    }
  }
}
