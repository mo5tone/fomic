import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/source/source_id.dart';

class ComicStatus {
  static const unknown = ComicStatus._('未知');
  static const ongoing = ComicStatus._('连载');
  static const completed = ComicStatus._('完结');
  static const licensed = ComicStatus._('未授权');

  final String name;

  const ComicStatus._(this.name);
}

class Comic implements Cloneable<Comic> {
  SourceID id;
  String url;
  String thumbnailUrl;
  String title;
  String artist;
  String author;
  String genre;
  String description;
  ComicStatus status = ComicStatus.unknown;
  List<Chapter> chapters = [];

  @override
  String toString() {
    return '''
    {
      id: ${id.index},
      url: $url,
      thumbnailUrl: $thumbnailUrl,
      title: $title,
      artist: $artist, 
      author: $author,
      genre: $genre,
      description: $description,
      status: $status,
      chapters: $chapters,
    }
    ''';
  }

  @override
  Comic clone({
    String url,
    String thumbnailUrl,
    String title,
    String artist,
    String author,
    String genre,
    String description,
    ComicStatus status,
    List<Chapter> chapters,
  }) {
    return Comic()
      ..id = this.id
      ..url = url ?? this.url
      ..thumbnailUrl = thumbnailUrl ?? this.thumbnailUrl
      ..title = title ?? this.title
      ..artist = artist ?? this.artist
      ..author = author ?? this.author
      ..genre = genre ?? this.genre
      ..description = description ?? this.description
      ..status = status ?? this.status
      ..chapters = chapters ?? this.chapters;
  }
}
