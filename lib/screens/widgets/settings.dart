import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/sorter/sorter_bloc.dart';
import 'package:sorty/blocs/visualizer/visualizer_bloc.dart';
import 'package:sorty/screens/widgets/settings/algorithm_settings.dart';
import 'package:sorty/screens/widgets/settings/animationdelay_settings.dart';
import 'package:sorty/screens/widgets/settings/elements_settings.dart';
import 'package:sorty/screens/widgets/settings/shufflerange_settings.dart';
import 'package:sorty/screens/widgets/settings/visualizer_settings.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
            VisualizerSettings(),
            Divider(
              color: Colors.grey,
              indent: 20,
            ),
            AlgorithmSettings(),
            Divider(
              color: Colors.grey,
              indent: 20,
            ),
            ElementsSettings(),
            Divider(
              color: Colors.grey,
              indent: 20,
            ),
            ShuffleRangeSettings(),
            Divider(
              color: Colors.grey,
              indent: 20,
            ),
            AnimationDelaySettings(),
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
