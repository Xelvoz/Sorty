import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/sorter/sorter_bloc.dart';
import 'package:sorty/screens/widgets/settings.dart';
import 'package:sorty/sorting/array_feed.dart';

class ElementsSettings extends StatefulWidget {
  @override
  _ElementsSettingsState createState() => _ElementsSettingsState();
}

class _ElementsSettingsState extends State<ElementsSettings> {
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
      title: "${elements.toInt()}x Elements",
      titleColor: Color(0xfff5cd79),
      body: Slider(
          activeColor: Color(0xfff5cd79),
          label: "${elements.toInt()} integers",
          min: 10.0,
          max: 200.0,
          divisions: 19,
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
    );
  }
}
