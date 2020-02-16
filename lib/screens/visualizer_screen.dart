import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/algorithms/quicksort.dart';
import 'package:sorty/sorting/array_generator.dart';
import 'package:sorty/visualizers/bars_visualizer.dart';

class VisualizerScreen extends StatefulWidget {
  @override
  _VisualizerScreenState createState() => _VisualizerScreenState();
}

class _VisualizerScreenState extends State<VisualizerScreen> {
  AbstractSorter _sorter = Quicksort(arrayGenerator: ArrayGenerator(100));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _sorter.closeStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<List<int>>(
              initialData: _sorter.arrayGenerator.initialArray,
              stream: _sorter.stream,
              builder: (context, snapshot) {
                return RepaintBoundary(
                  child: CustomPaint(
                    painter: BarsVisualizer(
                      array: snapshot?.data,
                      highlights: _sorter.highlightedNumbers,
                      specialHighlights: _sorter.specialHighlitedNumbers,
                    ),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: StreamBuilder<Object>(
          initialData: SortingStatus.IDLE,
          stream: _sorter.animationStatus.stream,
          builder: (context, snapshot) {
            return (snapshot?.data == SortingStatus.INPROGRESS)
                ? Container()
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                          mini: true,
                          heroTag: "shuffle",
                          backgroundColor: Colors.red[300],
                          child: Icon(Icons.autorenew),
                          onPressed: (snapshot?.data == SortingStatus.INPROGRESS)
                              ? null
                              : () {
                                  _sorter.shuffle();
                                }),
                      SizedBox(width: 10),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.blueGrey,
                        heroTag: "sort",
                        child: Icon(Icons.timeline),
                        onPressed: (snapshot?.data == SortingStatus.INPROGRESS)
                            ? null
                            : () {
                                _sorter.sort();
                              },
                      )
                    ],
                  );
          }),
    );
  }
}
