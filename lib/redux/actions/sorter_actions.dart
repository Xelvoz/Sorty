import 'dart:async';

import 'package:sorty/redux/actions/abstract_actions.dart';
import 'package:sorty/redux/app_state.dart';

enum SortingStatus { IDLE, INPROGRESS, COMPLETED }

class SortAction extends ReactiveAction<SortingStatus> {
  @override
  void before() {
    addEvent(SortingStatus.INPROGRESS);
  }

  @override
  Future<AppState> reduce() async {
    await state.sorter.sort();
    return state;
  }

  @override
  Future<void> after() async {
    addEvent(SortingStatus.INPROGRESS);
    await Future.delayed(Duration(seconds: 2), () => addEvent(SortingStatus.IDLE));
  }
}

class ShuffleAction extends ReactiveAction {
  @override
  Future<AppState> reduce() async {
    state.sorter.shuffle();
    return state;
  }
}
