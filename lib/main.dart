import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorty/app.dart';
import 'package:sorty/redux/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final Store<AppState> store = Store(initialState: AppState.init());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (_) => runApp(
      Sorty(
        store: store,
        navigatorKey: navigatorKey,
      ),
    ),
  );
}
