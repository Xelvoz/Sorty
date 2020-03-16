import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:sorty/redux/app_state.dart';
import 'package:sorty/screens/visualizer_screen.dart';

class Sorty extends StatelessWidget {
  final Store<AppState> store;

  Sorty({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sorty 〽️ - Sorting Algorithms Visualization",
        home: VisualizerScreen(),
      ),
    );
  }
}
