import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/sorter/sorter_bloc.dart';
import 'package:sorty/blocs/visualizer/visualizer_bloc.dart';
import 'package:sorty/screens/widgets/visualization_paint.dart';
import 'package:sorty/screens/widgets/settings.dart';

class VisualizerScreen extends StatefulWidget {
  @override
  _VisualizerScreenState createState() => _VisualizerScreenState();
}

class _VisualizerScreenState extends State<VisualizerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SorterBloc, SorterState>(
      builder: (_, sorterState) {
        bool startSortingCondition = listEquals(
          sorterState.sorter.initialArray,
          sorterState.sorter.array,
        );
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: Color(0xFF333333),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BlocBuilder<VisualizerBloc, VisualizerState>(
                builder: (_, visualizerState) {
                  if (visualizerState is VisualizerLoaded)
                    return VisualizationPaint(
                      initialArray: sorterState.sorter.initialArray,
                      visualizer: visualizerState.func,
                    );
                  else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
            ),
          ),
          floatingActionButton: BlocBuilder<SorterBloc, SorterState>(
              builder: (context, state) => (state is SortingInProgress)
                  ? Container()
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        FloatingActionButton(
                            mini: true,
                            heroTag: "settings",
                            backgroundColor: Colors.amber.withOpacity(0.7),
                            child: Icon(Icons.settings),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            }),
                        SizedBox(width: 5),
                        FloatingActionButton(
                            mini: true,
                            heroTag: "reset",
                            backgroundColor: Colors.purple[300].withOpacity(0.7),
                            child: Icon(Icons.autorenew),
                            onPressed: () {
                              BlocProvider.of<SorterBloc>(context).add(Reset());
                            }),
                        FloatingActionButton(
                            mini: true,
                            heroTag: "shuffle",
                            backgroundColor: Colors.red[300].withOpacity(0.7),
                            child: Icon(Icons.shuffle),
                            onPressed: () {
                              BlocProvider.of<SorterBloc>(context).add(StartShuffle());
                            }),
                        SizedBox(width: 5),
                        FloatingActionButton(
                          mini: true,
                          disabledElevation: 0,
                          backgroundColor: startSortingCondition
                              ? Colors.grey
                              : Colors.blueGrey.withOpacity(0.7),
                          heroTag: "sort",
                          child: Stack(
                            alignment: Alignment.center,
                            fit: StackFit.expand,
                            children: <Widget>[
                              Icon(Icons.timeline),
                              startSortingCondition
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 24, left: 22),
                                      child: Icon(
                                        Icons.clear,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 24, left: 22),
                                      child: Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                    ),
                            ],
                          ),
                          onPressed: startSortingCondition
                              ? null
                              : () {
                                  BlocProvider.of<SorterBloc>(context).add(StartSort());
                                },
                        )
                      ],
                    )),
          drawerEdgeDragWidth: 0,
          drawer: Drawer(
            elevation: 10,
            child: Settings(),
          ),
        );
      },
    );
  }
}
