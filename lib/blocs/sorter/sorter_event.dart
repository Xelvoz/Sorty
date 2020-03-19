part of 'sorter_bloc.dart';

abstract class SorterEvent extends Equatable {
  const SorterEvent();
}

class StartSort extends SorterEvent {
  @override
  List<Object> get props => null;
}

class Reset extends SorterEvent {
  @override
  List<Object> get props => null;
}

class StartShuffle extends SorterEvent {
  @override
  List<Object> get props => null;
}

class ChangeElements extends SorterEvent {
  final int elements;

  ChangeElements(this.elements);

  @override
  List<Object> get props => [elements];
}

class ChangeShuffleRange extends SorterEvent {
  final RangeValues range;

  ChangeShuffleRange(this.range);

  @override
  List<Object> get props => [range];
}

class ChangeAnimationDelay extends SorterEvent {
  final int animationDelay;

  ChangeAnimationDelay(this.animationDelay);

  @override
  List<Object> get props => [animationDelay];
}

class ChangeAlgorithm extends SorterEvent {
  final Algorithm algorithm;

  ChangeAlgorithm(this.algorithm);

  @override
  List<Object> get props => [algorithm];
}
