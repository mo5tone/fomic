import 'package:flutter/material.dart';
import 'package:fomic/model/storage/key_values.dart';

class ThemeChangeNotifier with ChangeNotifier {
  Brightness _brightness;
  ColorSwatch _primarySwatch = Colors.blue;

  ThemeChangeNotifier() {
    KeyValues.shared.isReady.then((_) {
      final newBrightness = KeyValues.shared.brightness;
      if (_brightness != newBrightness) {
        _brightness = newBrightness;
        notifyListeners();
      }
      final newPrimarySwatch = KeyValues.shared.primarySwatch;
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
      KeyValues.shared.brightness = value;
    }
  }

  ColorSwatch get primarySwatch => _primarySwatch;

  set primarySwatch(ColorSwatch value) {
    if (value != null && value != _primarySwatch) {
      _primarySwatch = value;
      notifyListeners();
      KeyValues.shared.primarySwatch = value;
    }
  }
}
