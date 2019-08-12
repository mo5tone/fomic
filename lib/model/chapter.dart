import 'dart:convert';

import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chapter.g.dart';

@JsonSerializable()
class Chapter implements Cloneable {
  final SourceId sourceId;
  final String url;
  final String name;
  final DateTime updateAt;
  final num chapterNumber;
  final List<Page> pages;

  Chapter({
    this.sourceId,
    this.url,
    this.name,
    this.updateAt,
    this.chapterNumber,
    this.pages = const [],
  });

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
  @override
  clone({
    SourceId sourceId,
    String url,
    String name,
    DateTime updateAt,
    num chapterNumber,
    List<Page> pages,
  }) {
    return Chapter(
      sourceId: sourceId ?? this.sourceId,
      url: url ?? this.url,
      name: name ?? this.name,
      updateAt: updateAt ?? this.updateAt,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      pages: pages ?? this.pages,
    );
  }
}
