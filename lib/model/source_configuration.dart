import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_configuration.freezed.dart';

@freezed
class SourceConfiguration with _$SourceConfiguration {
  const factory SourceConfiguration.select(String title, List<String> options, {@Default(0) int state, String? summary}) = SourceConfigurationSelect;
  const factory SourceConfiguration.text(String title, {@Default('') String state, String? summary}) = SourceConfigurationText;
  const factory SourceConfiguration.check(String title, {@Default(false) bool state, String? summary}) = SourceConfigurationCheck;
}
