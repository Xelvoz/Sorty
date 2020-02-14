class ArrayGenerator {
  int elements;
  List<int> array;

  ArrayGenerator(this.elements) {
    array = List.from(initialArray);
  }

  List<int> get initialArray => List.generate(elements, (i) => i + 1);

  void shuffle() {
    array.shuffle();
  }

  void shuffleRange(int start, int end) {
    assert(start >= 0 && end <= array.length - 1);
    var shuffledRange = array.skip(start).take(end - start).toList();
    shuffledRange.shuffle();
    array.replaceRange(start, end, shuffledRange);
  }

  void shuffleFrom(int start) {
    assert(start >= 0 && start <= array.length - 1);
    shuffleRange(start, array.length - 1);
  }

  void shuffleUntil(int end) {
    assert(end >= 0 && end <= array.length - 1);
    shuffleRange(0, end);
  }

  void reset() {
    array = List.from(initialArray);
  }
}
