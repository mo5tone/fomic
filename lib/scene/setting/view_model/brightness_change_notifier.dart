import 'package:flutter/material.dart';

class BrightnessChangeNotifier with ChangeNotifier {
  Brightness _brightness;

  Brightness get brightness => _brightness;

  set brightness(Brightness value) {
    if (value != _brightness) {
      _brightness = value;
      notifyListeners();
    }
  }
}
