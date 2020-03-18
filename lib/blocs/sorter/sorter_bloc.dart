import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/algorithms/algorithm_factory.dart';
import 'package:sorty/sorting/algorithms/mergesort.dart';
import 'package:sorty/sorting/algorithms/quicksort.dart';
import 'package:sorty/sorting/array_generator.dart';

part 'sorter_event.dart';
part 'sorter_state.dart';

class SorterBloc extends Bloc<SorterEvent, SorterState> {
  static AbstractSorter DEFAULT_SORTER = MergeSort(arrayGenerator: ArrayGenerator(50));
  AbstractSorter sorter = DEFAULT_SORTER;
  Algorithm algorithm = Algorithm.Mergesort;

  @override
  SorterState get initialState => SortingIdle(DEFAULT_SORTER);

  @override
  Stream<SorterState> mapEventToState(SorterEvent event) async* {
    if (event is StartSort) {
      yield SortingInProgress(sorter);
      await sorter.sort();
    }

    if (event is StartShuffle) {
      sorter.shuffle();
    }

    if (event is ChangeElements) {
      var newArrayGen = sorter.arrayGenerator.copyWith(elements: event.elements);
      sorter = sorter.copyWith(arrayGenerator: newArrayGen);
      yield SorterLoaded(sorter);
    }

    if (event is ChangeShuffleRange) {
      var newArrayGen = sorter.arrayGenerator.copyWith(shuffleRange: event.range);
      sorter = sorter.copyWith(arrayGenerator: newArrayGen);
      yield SorterLoaded(sorter);
    }

    if (event is ChangeAnimationDelay) {
      sorter = sorter.copyWith(animationDelay: event.animationDelay);
      yield SorterLoaded(sorter);
    }

    if (event is ChangeAlgorithm) {
      var newSorter = AlgorithmFactory.visualizerFunctionFromType(event.algorithm);
      algorithm = event.algorithm;
      sorter = newSorter.copyWith(
        animationDelay: sorter.animationDelay.inMilliseconds,
        arrayGenerator: sorter.arrayGenerator,
      );
      yield SorterLoaded(sorter);
    }

    yield SortingIdle(sorter);
  }
}
