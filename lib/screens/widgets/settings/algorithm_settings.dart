import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/sorter/sorter_bloc.dart';
import 'package:sorty/screens/widgets/settings.dart';
import 'package:sorty/sorting/algorithms/algorithm_factory.dart';

class AlgorithmSettings extends StatefulWidget {
  @override
  _AlgorithmSettingsState createState() => _AlgorithmSettingsState();
}

class _AlgorithmSettingsState extends State<AlgorithmSettings> {
  SorterBloc sorterBloc;
  int algorithm;

  @override
  Widget build(BuildContext context) {
    sorterBloc = BlocProvider.of<SorterBloc>(context);
    algorithm = sorterBloc.algorithm.index;

    return Setting(
      title: "Algorithm",
      titleColor: Colors.orange[300],
      body: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xff333333),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: DropdownButton(
              iconSize: 30,
              iconEnabledColor: Colors.orange[300],
              icon: Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Icon(Icons.extension),
              ),
              value: algorithm,
              underline: Container(),
              items: Algorithm.values
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
                  algorithm = vt;
                });
                sorterBloc.add(ChangeAlgorithm(Algorithm.values[vt]));
              }),
        ),
      ),
    );
  }
}
