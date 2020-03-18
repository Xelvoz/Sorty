import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/sorter/sorter_bloc.dart';
import 'package:sorty/screens/widgets/settings.dart';

class AnimationDelaySettings extends StatefulWidget {
  @override
  _AnimationDelaySettingsState createState() => _AnimationDelaySettingsState();
}

class _AnimationDelaySettingsState extends State<AnimationDelaySettings> {
  SorterBloc sorterBloc;
  double animationDelay;

  @override
  Widget build(BuildContext context) {
    sorterBloc = BlocProvider.of<SorterBloc>(context);
    animationDelay = sorterBloc.sorter.animationDelay.inMilliseconds.toDouble();

    return Setting(
      title: "Animation Delay (${animationDelay.toInt()}ms)",
      titleColor: Color(0xff3dc1d3),
      body: Slider(
        activeColor: Color(0xff3dc1d3),
        label: "${animationDelay.toInt()}ms",
        min: 1.0,
        max: 1000.0,
        divisions: 40,
        value: animationDelay,
        onChanged: (val) {
          setState(() {
            animationDelay = val;
          });
          sorterBloc.add(ChangeAnimationDelay(val.toInt()));
        },
      ),
    );
  }
}
