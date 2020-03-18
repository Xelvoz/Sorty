import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/visualizer/visualizer_bloc.dart';
import 'package:sorty/screens/widgets/settings.dart';
import 'package:sorty/visualizers/visualizer_factory.dart';

class VisualizerSettings extends StatefulWidget {
  @override
  _VisualizerSettingsState createState() => _VisualizerSettingsState();
}

class _VisualizerSettingsState extends State<VisualizerSettings> {
  VisualizerBloc visualizerBloc;
  int visualizerType;

  @override
  Widget build(BuildContext context) {
    visualizerBloc = BlocProvider.of<VisualizerBloc>(context);
    visualizerType = visualizerBloc.visualizerType.index;
    return Setting(
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
              iconEnabledColor: Colors.red[300],
              icon: Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Icon(Icons.format_paint),
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
    );
  }
}
