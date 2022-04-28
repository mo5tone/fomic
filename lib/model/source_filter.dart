import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_filter.freezed.dart';

@freezed
class SourceFilter with _$SourceFilter {
  const factory SourceFilter.header(String name) = SourceFilterHeader;
  const factory SourceFilter.separator({@Default('') String name}) = SourceFilterSeparator;
  const factory SourceFilter.select(String name, List<String> options, {@Default(0) int state}) = SourceFilterSelect;
  const factory SourceFilter.text(String name, {@Default('') String state}) = SourceFilterText;
  const factory SourceFilter.check(String name, {@Default(false) bool state}) = SourceFilterCheck;
  const factory SourceFilter.sort(String name, List<String> options, int state, bool ascending) = SourceFilterSort;
}
