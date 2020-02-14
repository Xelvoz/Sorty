import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppState extends Equatable {
  AppState();

  factory AppState.init() => AppState();

  @override
  List<Object> get props => [];
}
