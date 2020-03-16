import 'dart:async';

class ArrayUpdates {
  final List<int> array;
  final List<int> highlightedNumbers;
  final List<int> specialHighlitedNumbers;

  ArrayUpdates({
    this.array,
    this.highlightedNumbers = const [],
    this.specialHighlitedNumbers = const [],
  });
}

class ArrayFeed {
  static StreamController<ArrayUpdates> _streamController = StreamController();

  ArrayFeed._();

  static void addUpdate(ArrayUpdates arrayUpdate) => _streamController?.add(arrayUpdate);

  static Stream<ArrayUpdates> get stream => ArrayFeed._streamController?.stream;

  static close() => ArrayFeed._streamController?.close();
}
