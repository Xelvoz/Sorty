import 'package:equatable/equatable.dart';
import 'package:sorty/sorting/abstract_sorter.dart';
import 'package:sorty/sorting/algorithms/quicksort.dart';
import 'package:sorty/sorting/array_generator.dart';
import 'package:sorty/visualizers/visualizer_factory.dart';

class AppState extends Equatable {
  final Function visualizer;
  final AbstractSorter sorter;

  AppState({this.visualizer, this.sorter});

  factory AppState.init() => AppState(
        visualizer: VisualizerFactory.bars,
        sorter: Quicksort(arrayGenerator: ArrayGenerator(50)),
      );

  AppState copyWith({visualizer, sorter}) {
    return AppState(
      sorter: sorter ?? this.sorter,
      visualizer: visualizer ?? this.visualizer,
    );
  }

  @override
  List<Object> get props => [
        visualizer.toString(),
        sorter.animationDelay,
        sorter.arrayGenerator,
      ];
}
