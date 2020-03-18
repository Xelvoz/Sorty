import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/sorter/sorter_bloc.dart';
import 'package:sorty/screens/widgets/settings.dart';

class ShuffleRangeSettings extends StatefulWidget {
  @override
  _ShuffleRangeSettingsState createState() => _ShuffleRangeSettingsState();
}

class _ShuffleRangeSettingsState extends State<ShuffleRangeSettings> {
  SorterBloc sorterBloc;
  double elements;
  double shuffleRangeStart;
  double shuffleRangeEnd;

  @override
  Widget build(BuildContext context) {
    sorterBloc = BlocProvider.of<SorterBloc>(context);
    elements = sorterBloc.sorter.arrayGenerator.elements.toDouble();
    shuffleRangeStart = sorterBloc.sorter.arrayGenerator.shuffleRange.start + 1;
    shuffleRangeEnd = sorterBloc.sorter.arrayGenerator.shuffleRange.end + 1;
    return Setting(
      title: "Shuffle Range (${shuffleRangeStart.toInt() - 1}-${shuffleRangeEnd.toInt() - 1})",
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
    );
  }
}
