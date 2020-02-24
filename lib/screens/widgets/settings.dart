import 'package:flutter/material.dart';

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
  void initState() {
    elements = 200;
    animationDelay = 10;
    shuffleRangeStart = 1.0;
    shuffleRangeEnd = elements;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  max: 1000.0,
                  divisions: 99,
                  value: elements,
                  onChanged: (value) {
                    setState(() {
                      elements = value;
                      if (shuffleRangeEnd >= elements) shuffleRangeEnd = elements;
                      if (shuffleRangeStart >= elements) shuffleRangeStart = 1.0;
                    });
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
                  if (range.end != range.start)
                    setState(() {
                      shuffleRangeStart = range.start;
                      shuffleRangeEnd = range.end;
                    });
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
                divisions: 10,
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
