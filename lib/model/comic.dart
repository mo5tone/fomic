import 'package:fomic/source/base/remote_source.dart';

import 'cloneable.dart';

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
  ComicStatus status = ComicStatus.unknown;
  String thumbnailUrl;

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
  Comic clone() {
    return Comic()
      ..source = source
      ..url = url
      ..title = title
      ..artist = artist
      ..author = author
      ..description = description
      ..genre = genre
      ..thumbnailUrl = thumbnailUrl;
  }
}
