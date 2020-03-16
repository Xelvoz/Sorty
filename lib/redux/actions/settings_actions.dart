import 'package:flutter/material.dart';
import 'package:sorty/redux/actions/abstract_actions.dart';
import 'package:sorty/redux/app_state.dart';

class ChangeElementsAction extends ReactiveAction {
  final int elements;
  ChangeElementsAction(this.elements);

  @override
  AppState reduce() {
    var newArrayGen = state.sorter.arrayGenerator.copyWith(elements: elements);
    var newSorter = state.sorter.copyWith(arrayGenerator: newArrayGen);
    return state.copyWith(sorter: newSorter);
  }
}

class ChangeShuffleRangeAction extends ReactiveAction {
  final RangeValues range;
  ChangeShuffleRangeAction(this.range);

  @override
  AppState reduce() {
    var rangeLerp = RangeValues(range.start - 1, range.end - 1);
    var newArrayGen = state.sorter.arrayGenerator.copyWith(shuffleRange: rangeLerp);
    var newSorter = state.sorter.copyWith(arrayGenerator: newArrayGen);
    return state.copyWith(sorter: newSorter);
  }
}
