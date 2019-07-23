import 'dart:math';

import 'package:fomic/common/helper/pair.dart';

abstract class Filter<K, V> {
  String get name;

  List get options;

  final K key;

  V get value;

  String get description;

  Filter(this.key);
}

abstract class F<Q> {
  String get name;

  List<Pair<String, Q>> get options;

  Pair<String, Q> find({int index, String alias}) {
    var i = index ?? 0;
    i = min(max(i, 0), options.length - 1);
    return options.firstWhere((pair) => pair.first == alias,
        orElse: () => options[i]);
  }
}
