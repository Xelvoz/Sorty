part of 'visualizer_bloc.dart';

abstract class VisualizerEvent extends Equatable {
  const VisualizerEvent();
}

class ChangeVisualizer extends VisualizerEvent {
  final VisualizerType type;

  ChangeVisualizer(this.type);

  @override
  List<Object> get props => [type];
}
