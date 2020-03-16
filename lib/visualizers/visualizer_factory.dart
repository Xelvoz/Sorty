import 'package:sorty/visualizers/rbgcircle_visualizer.dart';
import 'package:sorty/visualizers/signal_visualizer.dart';
import 'package:sorty/visualizers/spiral_visualizer.dart';

import 'bars_visualizer.dart';

enum VisualizerType { Bars, RGBCircle, Spiral, Signal }

class VisualizerFactory {
  VisualizerFactory._();

  static BarsVisualizer bars({
    array,
    highlights,
    specialHighlights,
  }) =>
      BarsVisualizer(
        array: array,
        highlights: highlights,
        specialHighlights: specialHighlights,
      );

  static RGBCircleVisualizer rgbCircle({
    array,
    highlights,
    specialHighlights,
  }) =>
      RGBCircleVisualizer(
        array: array,
        highlights: highlights,
        specialHighlights: specialHighlights,
      );

  static SpiralVisualizer spiral({
    array,
    highlights,
    specialHighlights,
  }) =>
      SpiralVisualizer(
        array: array,
        highlights: highlights,
        specialHighlights: specialHighlights,
      );

  static SignalVisualizer signal({
    array,
    highlights,
    specialHighlights,
  }) =>
      SignalVisualizer(
        array: array,
        highlights: highlights,
        specialHighlights: specialHighlights,
      );
}
