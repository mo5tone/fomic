import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';

@freezed
class Filter with _$Filter {
  const factory Filter.note(String name) = FilterNote;
  const factory Filter.text(String name, {@Default('') String value}) = FilterText;
  const factory Filter.check(String name, {@Default(false) bool allowsExclusion, @Default(false) bool value}) = FilterCheck;
  const factory Filter.select(String name, List<MapEntry<String, dynamic>> options, {@Default(0) int value}) = FilterSelect;
  const factory Filter.group(String name, List<Filter> filterList) = FilterGroup;
  const factory Filter.sort(String name, List<MapEntry<String, dynamic>> options, int value, bool ascending) = FilterSort;
}
