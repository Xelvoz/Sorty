import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/sorter/sorter_bloc.dart';
import 'package:sorty/blocs/visualizer/visualizer_bloc.dart';
import 'package:sorty/sorting/array_feed.dart';
import 'package:sorty/visualizers/visualizer_factory.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double elements;
  double animationDelay;
  double shuffleRangeStart;
  double shuffleRangeEnd;
  int visualizerType;

  VisualizerBloc visualizerBloc;
  SorterBloc sorterBloc;

  @override
  Widget build(BuildContext context) {
    visualizerBloc = BlocProvider.of<VisualizerBloc>(context);
    sorterBloc = BlocProvider.of<SorterBloc>(context);

    elements = sorterBloc.sorter.arrayGenerator.elements.toDouble();
    animationDelay = sorterBloc.sorter.animationDelay.inMilliseconds.toDouble();
    shuffleRangeStart = sorterBloc.sorter.arrayGenerator.shuffleRange.start + 1;
    shuffleRangeEnd = sorterBloc.sorter.arrayGenerator.shuffleRange.end + 1;
    visualizerType = visualizerBloc.visualizerType.index;

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 30),
      color: Color(0xff292929),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Setting(
              title: "Visualizer",
              titleColor: Colors.red[300],
              body: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Color(0xff333333),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: DropdownButton(
                      iconSize: 30,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Icon(Icons.extension),
                      ),
                      value: visualizerType,
                      underline: Container(),
                      items: VisualizerType.values
                          .map((vt) => DropdownMenuItem(
                                value: vt.index,
                                child: Text(
                                  "${vt.toString().split(".")[1]}",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (int vt) {
                        setState(() {
                          visualizerType = vt;
                        });
                        visualizerBloc.add(ChangeVisualizer(VisualizerType.values[vt]));
                      }),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 20,
            ),
            Setting(
              title: "Algorithm",
              titleColor: Color(0xfff3a683),
              body: Container(),
            ),
            Divider(
              color: Colors.grey,
              indent: 20,
            ),
            Setting(
              title: "${elements.toInt()}x Elements",
              titleColor: Color(0xfff5cd79),
              body: Slider(
                  activeColor: Color(0xfff5cd79),
                  label: "${elements.toInt()} integers",
                  min: 10.0,
                  max: 500.0,
                  divisions: 49,
                  value: elements,
                  onChangeEnd: (_) {
                    ArrayFeed.addUpdate(ArrayUpdates(array: sorterBloc.sorter.array));
                  },
                  onChanged: (value) {
                    setState(() {
                      elements = value;
                      shuffleRangeEnd = elements;
                      if (shuffleRangeStart >= elements) shuffleRangeStart = 1.0;
                    });
                    sorterBloc.add(ChangeElements(value.toInt()));
                    sorterBloc.add(ChangeShuffleRange(
                      RangeValues(shuffleRangeStart - 1, shuffleRangeEnd - 1),
                    ));
                  }),
            ),
            Divider(
              color: Colors.grey,
              indent: 20,
            ),
            Setting(
              title:
                  "Shuffle Range (${shuffleRangeStart.toInt() - 1}-${shuffleRangeEnd.toInt() - 1})",
              titleColor: Color(0xff546de5),
              body: RangeSlider(
                activeColor: Color(0xff546de5),
                labels: RangeLabels(
                  "From Index ${shuffleRangeStart.toInt() - 1}",
                  "To Index ${shuffleRangeEnd.toInt() - 1}",
                ),
                min: 1.0,
                max: elements,
                divisions: (elements ~/ 10),
                values: RangeValues(shuffleRangeStart, shuffleRangeEnd),
                onChanged: (range) {
                  if (range.end != range.start) {
                    setState(() {
                      shuffleRangeStart = range.start;
                      shuffleRangeEnd = range.end;
                    });
                    sorterBloc.add(ChangeShuffleRange(RangeValues(range.start - 1, range.end - 1)));
                  }
                },
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 20,
            ),
            Setting(
              title: "Animation Delay (${animationDelay.toInt()}ms)",
              titleColor: Color(0xff3dc1d3),
              body: Slider(
                activeColor: Color(0xff3dc1d3),
                label: "${animationDelay.toInt()}ms",
                min: 1.0,
                max: 1000.0,
                divisions: 20,
                value: animationDelay,
                onChanged: (val) {
                  setState(() {
                    animationDelay = val;
                  });
                  sorterBloc.add(ChangeAnimationDelay(val.toInt()));
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget body;

  Setting({this.title, this.titleColor, this.body});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: titleColor ?? Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
                decorationThickness: 0.2,
                decorationColor: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          body
        ],
      ),
    );
  }
}
