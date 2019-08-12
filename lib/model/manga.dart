import 'dart:convert';

import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga.g.dart';

enum MangaStatus {
  unknown,
  ongoing,
  completed,
  licensed,
}

@JsonSerializable()
class Manga implements Cloneable<Manga> {
  final SourceId sourceId;
  final String url;
  final String thumbnailUrl;
  final String title;
  final String artist;
  final String author;
  final String genre;
  final String description;
  final MangaStatus status;
  final List<Chapter> chapters;

  Manga({
    this.sourceId,
    this.url,
    this.thumbnailUrl,
    this.title,
    this.artist,
    this.author,
    this.genre,
    this.description,
    this.status = MangaStatus.unknown,
    this.chapters = const [],
  }) : assert(sourceId != null);

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

  Map<String, dynamic> toJson() => _$MangaToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  @override
  Manga clone({
    SourceId sourceId,
    String url,
    String thumbnailUrl,
    String title,
    String artist,
    String author,
    String genre,
    String description,
    MangaStatus status,
    List<Chapter> chapters,
  }) {
    return Manga(
      sourceId: sourceId ?? this.sourceId,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
      status: status ?? this.status,
      chapters: chapters ?? this.chapters,
    );
  }
}