import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:sorty/redux/app_state.dart';

class Sorty extends StatelessWidget {
  final navigatorKey;
  final Store<AppState> store;

  Sorty({this.navigatorKey, this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sorty 〽️ - Sorting Algorithms Visualization",
        navigatorKey: navigatorKey,
      ),
    );
  }
}
