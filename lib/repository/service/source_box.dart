import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _Key {
  current,
}

extension on _Key {
  String get rawValue => describeEnum(this);
}

class SourceBox {
  static final provider = FutureProvider((ref) async => SourceBox._(await Hive.openBox<int>('source')));

  final Box<int> _box;

  SourceBox._(this._box);

  int get id => _box.get(_Key.current.rawValue, defaultValue: -1) ?? -1;

  set id(int value) {
    _box.put(_Key.current.rawValue, value);
  }
}
