import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/algorithms/quicksort.dart';
import 'package:sorty/sorting/array_generator.dart';

part 'sorter_event.dart';
part 'sorter_state.dart';

class SorterBloc extends Bloc<SorterEvent, SorterState> {
  static AbstractSorter DEFAULT_SORTER = Quicksort(arrayGenerator: ArrayGenerator(50));

  AbstractSorter sorter = DEFAULT_SORTER;

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

    yield SortingIdle(sorter);
  }
}
