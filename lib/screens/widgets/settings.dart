import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:sorty/redux/actions/settings_actions.dart';
import 'package:sorty/redux/app_state.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double elements;
  double animationDelay;
  String algorithm;
  double shuffleRangeStart;
  double shuffleRangeEnd;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      onInit: (store) {
        elements = store.state.sorter.arrayGenerator.elements.toDouble();
        animationDelay = store.state.sorter.animationDelay.inMilliseconds.toDouble();
        shuffleRangeStart = store.state.sorter.arrayGenerator.shuffleRange.start + 1;
        shuffleRangeEnd = store.state.sorter.arrayGenerator.shuffleRange.end + 1;
      },
      converter: (store) => store,
      builder: (_, store) => Container(
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
                body: Container(),
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
                    onChanged: (value) {
                      setState(() {
                        elements = value;
                        shuffleRangeEnd = elements;
                        if (shuffleRangeStart >= elements) shuffleRangeStart = 1.0;
                      });
                      store.dispatch(ChangeElementsAction(value.toInt()));
                      store.dispatch(ChangeShuffleRangeAction(
                        RangeValues(shuffleRangeStart, shuffleRangeEnd),
                      ));
                      Scaffold.of(context).setState(() {});
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
                      store.dispatch(ChangeShuffleRangeAction(range));
                      Scaffold.of(context).setState(() {});
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
                  },
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
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