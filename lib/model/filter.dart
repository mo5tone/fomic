import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';

@freezed
class Filter with _$Filter {
  const factory Filter.header(String name) = FilterHeader;
  const factory Filter.separator({@Default('') String name}) = FilterSeparator;
  const factory Filter.select(String name, List<String> options, {@Default(0) int state}) = FilterSelect;
  const factory Filter.text(String name, {@Default('') String state}) = FilterText;
  const factory Filter.check(String name, {@Default(false) bool state}) = FilterCheck;
  const factory Filter.sort(String name, List<String> options, int state, bool ascending) = FilterSort;
}
