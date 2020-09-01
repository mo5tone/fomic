import 'package:flutter/material.dart';

class ThemeChangeNotifier with ChangeNotifier {
  Brightness _brightness;
  ColorSwatch _primarySwatch = Colors.blue;

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
    }
  }

  ColorSwatch get primarySwatch => _primarySwatch;

  set primarySwatch(ColorSwatch value) {
    if (value != null && value != _primarySwatch) {
      _primarySwatch = value;
      notifyListeners();
    }
  }
}
