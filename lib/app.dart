import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorty/blocs/sorter/sorter_bloc.dart';
import 'package:sorty/blocs/visualizer/visualizer_bloc.dart';
import 'package:sorty/screens/visualizer_screen.dart';

class Sorty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VisualizerBloc>(
          create: (_) => VisualizerBloc(),
        ),
        BlocProvider<SorterBloc>(
          create: (_) => SorterBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sorty 〽️ - Sorting Algorithms Visualization",
        home: VisualizerScreen(),
      ),
    );
  }
}
