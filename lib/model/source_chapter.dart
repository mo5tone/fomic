import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_chapter.freezed.dart';

@freezed
class SourceChapter with _$SourceChapter {
  factory SourceChapter(
    String key,
    String name, {
    @Default(0) int dateUpload,
    @Default(-1) double number,
    @Default('') String scanlator,
  }) = _SourceChapter;
}
