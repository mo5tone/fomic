import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/primary_swatch.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _Key {
  useMaterial3,
  brightness,
  primarySwatch;

  @override
  String toString() => describeEnum(this);
}

class ThemeBox {
  static final provider = FutureProvider.autoDispose((ref) async => ThemeBox._(await Hive.openBox('theme')));

  final Box _box;

  ThemeBox._(this._box);

  bool get useMaterial3 {
    final key = '${_Key.useMaterial3}';
    return _box.get(key, defaultValue: true);
  }

  set useMaterial3(bool value) {
    final key = '${_Key.useMaterial3}';
    _box.put(key, value);
  }

  Brightness? get brightness {
    final key = '${_Key.brightness}';
    int? index = _box.get(key);
    if (index != null && index > -1 && index < Brightness.values.length) {
      return Brightness.values[index];
    }
    return null;
  }

  set brightness(Brightness? value) {
    final key = '${_Key.brightness}';
    if (value == null) {
      _box.delete(key);
    } else {
      _box.put(key, Brightness.values.indexOf(value));
    }
  }

  MaterialColor get primarySwatch {
    final key = '${_Key.primarySwatch}';
    PrimarySwatch swatch = _box.get(key, defaultValue: PrimarySwatch.blue);
    return swatch.color;
  }

  set primarySwatch(MaterialColor value) {
    final key = '${_Key.primarySwatch}';
    final swatch = PrimarySwatch.values.firstWhere(
      (e) => e.color == value,
      orElse: () => PrimarySwatch.blue,
    );
    _box.put(key, swatch);
  }
}
