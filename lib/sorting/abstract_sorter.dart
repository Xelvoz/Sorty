import 'package:sorty/sorting/array_generator.dart';

abstract class AbstractSorter {
  final String name;
  final Duration animationDelay;
  final List<int> highlightedNumbers = List();
  final List<int> specialHighlitedNumbers = List();
  final ArrayGenerator arrayGenerator;

  AbstractSorter({
    this.name,
    this.animationDelay = const Duration(milliseconds: 500),
    this.arrayGenerator,
  });

  Future<void> sort();

  void reset() {
    highlightedNumbers.clear();
    specialHighlitedNumbers.clear();
    arrayGenerator.reset();
  }
}
