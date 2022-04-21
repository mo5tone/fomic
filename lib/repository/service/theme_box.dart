import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive/hive.dart';

const primarySwatches = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];

enum _Key {
  brightness,
  primarySwatch,
}

extension on _Key {
  String get rawValue => describeEnum(this);
}

class ThemeBox {
  static final provider = FutureProvider.autoDispose((ref) async => ThemeBox._(await Hive.openBox<int>('theme')));

  final Box<int> _box;

  ThemeBox._(this._box);

  Brightness get brightness {
    final index = _box.get(_Key.brightness.rawValue, defaultValue: -1);
    if (index != null && index > -1 && index < Brightness.values.length) {
      return Brightness.values[index];
    }
    return Brightness.light;
  }

  set brightness(Brightness value) {
    _box.put(_Key.brightness.rawValue, Brightness.values.indexOf(value));
  }

  MaterialColor get primarySwatch {
    final index = _box.get(_Key.primarySwatch.rawValue, defaultValue: -1);
    if (index != null && index > -1 && index < primarySwatches.length) {
      return primarySwatches[index];
    }
    return Colors.blue;
  }

  set primarySwatch(MaterialColor value) {
    _box.put(_Key.primarySwatch.rawValue, primarySwatches.indexOf(value));
  }
}
