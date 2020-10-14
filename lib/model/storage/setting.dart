import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/constant/constant.dart';
import 'package:hive/hive.dart';

const _boxName = 'setting';

enum _Keys {
  brightness,
  primarySwatch,
}

extension on _Keys {
  String get rawValue => describeEnum(this);
}

class Setting {
  static Future<Setting> instance() => Hive.openBox(_boxName).then((b) => Setting._().._box = b);

  Box _box;

  Setting._();

  Brightness get brightness {
    int index = _box.get(_Keys.brightness.rawValue, defaultValue: -1);
    if (index > -1 && index < Brightness.values.length) {
      return Brightness.values[index];
    }
    return null;
  }

  set brightness(Brightness value) {
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
    final index = primarySwatches.indexOf(value);
    if (index > -1) {
      _box.put(_Keys.primarySwatch.rawValue, index);
    }
  }
}
