import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorty/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (_) => runApp(Sorty()),
  );
}
