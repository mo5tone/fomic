import 'package:flutter/material.dart';
import 'package:fomic/model/entity/setting.dart';

class ThemeChangeNotifier with ChangeNotifier {
  Brightness _brightness;
  ColorSwatch _primarySwatch = Colors.blue;

  ThemeChangeNotifier() {
    Setting.instance().then((setting) {
      final newBrightness = setting.brightness;
      if (_brightness != newBrightness) {
        _brightness = newBrightness;
        notifyListeners();
      }
      final newPrimarySwatch = setting.primarySwatch;
      if (newPrimarySwatch != null && _primarySwatch != newPrimarySwatch) {
        _primarySwatch = newPrimarySwatch;
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
      Setting.instance().then((setting) => setting.brightness = value);
    }
  }

  ColorSwatch get primarySwatch => _primarySwatch;

  set primarySwatch(ColorSwatch value) {
    if (value != null && value != _primarySwatch) {
      _primarySwatch = value;
      notifyListeners();
      Setting.instance().then((setting) => setting.primarySwatch = value);
    }
  }
}
