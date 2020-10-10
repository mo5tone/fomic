import 'package:flutter/material.dart';
import 'package:fomic/model/constant/constant.dart';
import 'package:fomic/model/preference/preferences.dart';

class ThemeChangeNotifier with ChangeNotifier {
  Brightness _brightness;
  ColorSwatch _primarySwatch = Colors.blue;

  ThemeChangeNotifier() {
    Preferences.shared.brightness.then((value) {
      Brightness newValue;
      if (value > -1 && value < Brightness.values.length) {
        newValue = Brightness.values[value];
      }
      if (_brightness != newValue) {
        _brightness = newValue;
        notifyListeners();
      }
    });
    Preferences.shared.primarySwatch.then((value) {
      final newValue = primarySwatchs[value];
      if (newValue != null && _primarySwatch != newValue) {
        _primarySwatch = newValue;
        notifyListeners();
      }
    });
  }

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

  Brightness get brightness => _brightness;

  set brightness(Brightness value) {
    if (value != _brightness) {
      _brightness = value;
      notifyListeners();
      Preferences.shared.brightness = Future(() => value == null ? 2 : Brightness.values.indexOf(value));
    }
  }

  ColorSwatch get primarySwatch => _primarySwatch;

  set primarySwatch(ColorSwatch value) {
    if (value != null && value != _primarySwatch) {
      _primarySwatch = value;
      notifyListeners();
      Preferences.shared.primarySwatch = Future(() => primarySwatchs.indexOf(value));
    }
  }
}
