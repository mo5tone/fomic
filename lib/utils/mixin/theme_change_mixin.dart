import 'package:flutter/material.dart';
import 'package:fomic/model/storage/setting.dart';

mixin ThemeChangeMixin on ChangeNotifier {
  Brightness _brightness;
  ColorSwatch _primarySwatch = Colors.blue;

  Future<void> initThemeChangeMixin() {
    return Setting.instance().then((setting) {
      brightness = setting.brightness;
      primarySwatch = setting.primarySwatch;
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
      Setting.instance().then((instance) => instance.brightness = value);
    }
  }

  ColorSwatch get primarySwatch => _primarySwatch;

  set primarySwatch(ColorSwatch value) {
    if (value != null && value != _primarySwatch) {
      _primarySwatch = value;
      notifyListeners();
      Setting.instance().then((instance) => instance.primarySwatch = value);
    }
  }
}
