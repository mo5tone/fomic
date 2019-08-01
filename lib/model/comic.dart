import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/source/base/remote_source.dart';

enum ComicStatus {
  unknown,
  ongoing,
  completed,
  licensed,
}

class Comic implements Cloneable<Comic> {
  RemoteSource source;
  String url;
  String title;
  String artist;
  String author;
  String description;
  String genre;
  ComicStatus comicStatus = ComicStatus.unknown;
  String thumbnailUrl;

  String get status {
    switch (comicStatus) {
      case ComicStatus.ongoing:
        return '连载';
      case ComicStatus.completed:
        return '完结';
      case ComicStatus.licensed:
        return '未授权';
      default:
        return '未知';
    }
  }

  @override
  String toString() {
    return '''
    Comic{
      source: ${source.runtimeType},
      url: $url,
      title: $title,
      artist: $artist, 
      author: $author,
      description: $description,
      genre: $genre,
      thumbnailUrl: $thumbnailUrl,
      status: $status,
    }
    ''';
  }

  @override
  Comic clone({
    String url,
    String title,
    String artist,
    String author,
    String description,
    String genre,
    ComicStatus comicStatus = ComicStatus.unknown,
    String thumbnailUrl,
  }) {
    return Comic()
      ..source = this.source
      ..url = url ?? this.url
      ..title = title ?? this.title
      ..artist = artist ?? this.artist
      ..author = author ?? this.author
      ..description = description ?? this.description
      ..genre = genre ?? this.genre
      ..comicStatus = comicStatus ?? this.comicStatus
      ..thumbnailUrl = thumbnailUrl ?? this.thumbnailUrl;
  }
}
