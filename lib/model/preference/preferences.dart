import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences shared = Preferences._();
  final Future<SharedPreferences> _pref;

  Preferences._() : _pref = SharedPreferences.getInstance();

  Future<int> get brightness => _pref.then((value) => value.getInt(_Keys.brightness.rawValue) ?? 2);

  set brightness(Future<int> value) {
    Future.wait([_pref, value]).then((futures) => (futures[0] as SharedPreferences).setInt(_Keys.brightness.rawValue, futures[1]));
  }

  Future<int> get primarySwatch => _pref.then((value) => value.getInt(_Keys.primarySwatch.rawValue) ?? primarySwatchs.indexOf(Colors.blue));

  set primarySwatch(Future<int> value) {
    Future.wait([_pref, value]).then((futures) => (futures[0] as SharedPreferences).setInt(_Keys.primarySwatch.rawValue, futures[1]));
  }
}

enum _Keys {
  brightness,
  primarySwatch,
}

extension on _Keys {
  String get rawValue => describeEnum(this);
}
