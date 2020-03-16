import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:sorty/redux/actions/sorter_actions.dart';
import 'package:sorty/redux/app_state.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/screens/widgets/settings.dart';
import 'package:sorty/visualizers/visualizer_factory.dart';

class VisualizerScreen extends StatefulWidget {
  @override
  _VisualizerScreenState createState() => _VisualizerScreenState();
}

class _VisualizerScreenState extends State<VisualizerScreen> {
  ShuffleAction shuffleAction = ShuffleAction();
  SortAction sortAction = SortAction();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      rebuildOnChange: true,
      builder: (_, store) => Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xFF333333),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<ArrayUpdates>(
                initialData: ArrayUpdates(array: store.state.sorter.arrayGenerator.initialArray),
                stream: ArrayFeed.stream,
                builder: (context, snapshot) {
                  return RepaintBoundary(
                    child: CustomPaint(
                      willChange: true,
                      painter: VisualizerFactory.signal(
                        array: snapshot?.data?.array,
                        highlights: snapshot?.data?.highlightedNumbers,
                        specialHighlights: snapshot?.data?.specialHighlitedNumbers,
                      ),
                    ),
                  );
                }),
          ),
        ),
        floatingActionButton: StreamBuilder<SortingStatus>(
            initialData: SortingStatus.IDLE,
            stream: sortAction.stream,
            builder: (context, snapshot) {
              return (snapshot?.data == SortingStatus.INPROGRESS)
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
                            onPressed: (snapshot?.data == SortingStatus.INPROGRESS)
                                ? null
                                : () {
                                    Scaffold.of(context).openDrawer();
                                  }),
                        SizedBox(width: 5),
                        FloatingActionButton(
                            mini: true,
                            heroTag: "shuffle",
                            backgroundColor: Colors.red[300].withOpacity(0.7),
                            child: Icon(Icons.autorenew),
                            onPressed: (snapshot?.data == SortingStatus.INPROGRESS)
                                ? null
                                : () {
                                    store.dispatch(shuffleAction);
                                  }),
                        SizedBox(width: 5),
                        FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.blueGrey.withOpacity(0.7),
                          heroTag: "sort",
                          child: Icon(Icons.timeline),
                          onPressed: (snapshot?.data == SortingStatus.INPROGRESS)
                              ? null
                              : () {
                                  store.dispatch(sortAction);
                                },
                        )
                      ],
                    );
            }),
        drawerEdgeDragWidth: 0,
        drawer: Drawer(
          elevation: 10,
          child: Settings(),
        ),
      ),
    );
  }
}
