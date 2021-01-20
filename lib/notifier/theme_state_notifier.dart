import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fomic/storage/setting.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rpThemeStateNotifier = StateNotifierProvider((ref) => ThemeStateNotifier(ref.watch(rpSetting.future)));

class ThemeStateNotifier extends StateNotifier<ThemeState> {
  final Future<Setting> _setting;
  ThemeStateNotifier(this._setting) : super(ThemeState());

  set brightness(Brightness value) {
    if (value != state.brightness) {
      state = state.merge(brightness: value);
      _setting.then((setting) => setting.brightness = value);
    }
  }

  set primarySwatch(ColorSwatch value) {
    if (value != null && value != state.primarySwatch) {
      state = state.merge(brightness: state.brightness, primarySwatch: value);
      _setting.then((setting) => setting.primarySwatch = value);
    }
  }
}

class ThemeState with EquatableMixin {
  final Brightness brightness;
  final ColorSwatch primarySwatch;

  ThemeData get theme => ThemeData(
        brightness: brightness ?? Brightness.light,
        primarySwatch: primarySwatch,
      );

  ThemeData get darkTheme => brightness != null
      ? null
      : ThemeData(
          brightness: Brightness.dark,
          primarySwatch: primarySwatch,
        );

  ThemeState([this.brightness, this.primarySwatch = Colors.blue]);

  ThemeState merge({Brightness brightness, ColorSwatch primarySwatch = Colors.blue}) {
    return ThemeState(brightness, primarySwatch ?? this.primarySwatch);
  }

  @override
  List<Object> get props => [brightness, primarySwatch];
}
