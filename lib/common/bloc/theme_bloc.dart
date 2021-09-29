import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_bloc.freezed.dart';

@freezed
class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.primarySwatch(MaterialColor primarySwatch) = ThemeEventPrimarySwatch;
  const factory ThemeEvent.brightness([Brightness? brightness]) = ThemeEventBrightness;
}

@freezed
class ThemeState with _$ThemeState {
  const ThemeState._();
  const factory ThemeState(MaterialColor primarySwatch, [Brightness? brightness]) = _ThemeState;

  ThemeData get theme {
    return ThemeData(
      brightness: brightness,
      primarySwatch: primarySwatch,
    );
  }

  ThemeData? get darkTheme {
    if (brightness != null) return null;
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: primarySwatch,
    );
  }
}

class ThemeBLoC extends BLoC<ThemeEvent, ThemeState> {
  static final provider = StateNotifierProvider.autoDispose<ThemeBLoC, ThemeState>((ref) => ThemeBLoC._());

  ThemeBLoC._() : super(const ThemeState(Colors.blue));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) {
    return event.when(primarySwatch: (primarySwatch) async* {
      yield state.copyWith(primarySwatch: primarySwatch);
    }, brightness: (brightness) async* {
      yield state.copyWith(brightness: brightness);
    });
  }
}
