part of 'sorter_bloc.dart';

abstract class SorterState {
  AbstractSorter sorter;

  SorterState(this.sorter);
}

class SorterLoaded extends SorterState {
  final AbstractSorter sorter;

  SorterLoaded(this.sorter) : super(sorter);
}

class SortingInProgress extends SorterState {
  SortingInProgress(sorter) : super(sorter);
}

class SortingIdle extends SorterState {
  SortingIdle(sorter) : super(sorter);
}
