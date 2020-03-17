part of 'visualizer_bloc.dart';

abstract class VisualizerState extends Equatable {
  const VisualizerState();
}

class VisualizerLoaded extends VisualizerState {
  final Function func;

  VisualizerLoaded(this.func);

  @override
  List<Object> get props => [func.toString()];
}
