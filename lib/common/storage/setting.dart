import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/constant/constant.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rpSetting = FutureProvider((ref) => Hive.openBox('setting').then((b) => Setting._(b)));

enum _Keys {
  brightness,
  primarySwatch,
}

extension on _Keys {
  String get rawValue => describeEnum(this);
}

class Setting {
  final Box _box;

  Setting._(this._box);

  Brightness get brightness {
    int index = _box.get(_Keys.brightness.rawValue, defaultValue: -1);
    if (index > -1 && index < Brightness.values.length) {
      return Brightness.values[index];
    }
    return null;
  }

  set brightness(Brightness value) {
    if (value == brightness) return;
    _box.put(_Keys.brightness.rawValue, Brightness.values.indexOf(value));
  }

  ColorSwatch get primarySwatch {
    int index = _box.get(_Keys.primarySwatch.rawValue, defaultValue: -1);
    if (index > -1 && index < primarySwatches.length) {
      return primarySwatches[index];
    }
    return Colors.blue;
  }

  set primarySwatch(ColorSwatch value) {
    if (value == primarySwatch) return;
    final index = primarySwatches.indexOf(value);
    if (index > -1) {
      _box.put(_Keys.primarySwatch.rawValue, index);
    }
  }
}
