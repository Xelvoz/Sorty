import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sorty/visualizers/visualizer_factory.dart';

part 'visualizer_event.dart';
part 'visualizer_state.dart';

class VisualizerBloc extends Bloc<VisualizerEvent, VisualizerState> {
  Function visualizer;
  VisualizerType visualizerType = VisualizerType.Bars;

  @override
  VisualizerState get initialState => VisualizerLoaded(
        VisualizerFactory.visualizerFunctionFromType(VisualizerType.Bars),
      );

  @override
  Stream<VisualizerState> mapEventToState(VisualizerEvent event) async* {
    if (event is ChangeVisualizer) {
      visualizerType = event.type;
      yield VisualizerLoaded(VisualizerFactory.visualizerFunctionFromType(event.type));
    }
  }
}
