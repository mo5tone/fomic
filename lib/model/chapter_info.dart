import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_info.freezed.dart';

@freezed
class ChapterInfo with _$ChapterInfo {
  factory ChapterInfo(
    String key,
    String name, {
    @Default(0) int dateUpload,
    @Default(-1) double number,
    @Default('') String scanlator,
  }) = _ChapterInfo;
}
