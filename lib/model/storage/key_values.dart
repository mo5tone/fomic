import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/constant/constant.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValues {
  static final KeyValues shared = KeyValues._();
  SharedPreferences _preferences;

  KeyValues._() {
    isReady.then((_) => _preferences = GetIt.I.get());
  }

  Future<void> get isReady => GetIt.I.isReady<SharedPreferences>();

  Brightness get brightness {
    final index = _preferences.getInt(_Keys.brightness.rawValue) ?? -1;
    if (index > -1 && index < Brightness.values.length) {
      return Brightness.values[index];
    }
    return null;
  }

  set brightness(Brightness value) {
    final index = Brightness.values.indexOf(value);
    _preferences.setInt(_Keys.brightness.rawValue, index);
  }

  ColorSwatch get primarySwatch {
    final index = _preferences.getInt(_Keys.primarySwatch.rawValue);
    if (index > -1 && index < primarySwatchs.length) {
      return primarySwatchs[index];
    }
    return Colors.blue;
  }

  set primarySwatch(ColorSwatch value) {
    final index = primarySwatchs.indexOf(value);
    if (index != -1) {
      _preferences.setInt(_Keys.primarySwatch.rawValue, index);
    }
  }
}

enum _Keys {
  brightness,
  primarySwatch,
}

extension on _Keys {
  String get rawValue => describeEnum(this);
}
