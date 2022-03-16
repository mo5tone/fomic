import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manga_info.freezed.dart';
part 'manga_info.g.dart';

@HiveType(typeId: 0)
enum MangaInfoStatus {
  @HiveField(0)
  unknown,
  @HiveField(1)
  ongoing,
  @HiveField(2)
  completed,
  @HiveField(3)
  licensed,
  @HiveField(4)
  publishingFinished,
  @HiveField(5)
  cancelled,
  @HiveField(6)
  onHiatus,
}

@freezed
class MangaInfo with _$MangaInfo {
  factory MangaInfo(
    String key,
    String title, {
    @Default('') String artist,
    @Default('') String author,
    @Default('') String description,
    @Default([]) List<String> genres,
    @Default(MangaInfoStatus.unknown) MangaInfoStatus status,
    @Default('') String cover,
  }) = _MangaInfo;
}
