import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:sorty/redux/app_state.dart';

abstract class ReactiveAction<T> extends ReduxAction<AppState> {
  StreamController<T> _streamController;

  ReactiveAction() : super() {
    _streamController = StreamController();
  }

  void addEvent(T event) {
    _streamController.add(event);
  }

  Stream<T> get stream => _streamController?.stream;

  void close() {
    _streamController?.close();
  }

  @override
  FutureOr<AppState> reduce();
}
