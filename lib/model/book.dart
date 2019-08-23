import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/sources/base/source.dart';

enum BookStatus {
  unknown,
  ongoing,
  completed,
  licensed,
}

class Book implements Cloneable<Book> {
  final int sourceIdentityIndex;
  final String url;
  final String thumbnailUrl;
  final String title;
  final String artist;
  final String author;
  final String genre;
  final String description;
  final int bookStatusIndex;

  Source get source {
    return Source.of(SourceIdentity.values[sourceIdentityIndex ?? 0]);
  }

  BookStatus get status => BookStatus.values[bookStatusIndex ?? 0];

  Book(
    this.sourceIdentityIndex,
    this.url, {
    this.thumbnailUrl,
    this.title,
    this.artist,
    this.author,
    this.genre,
    this.description,
    this.bookStatusIndex = 0,
  })  : assert(sourceIdentityIndex != null),
        assert(url != null && url.isNotEmpty);

  @override
  Book clone({
    int sourceIdentityIndex,
    String url,
    String thumbnailUrl,
    String title,
    String artist,
    String author,
    String genre,
    String description,
    int bookStatusIndex,
  }) {
    return Book(
      sourceIdentityIndex ?? this.sourceIdentityIndex,
      url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
      bookStatusIndex: bookStatusIndex ?? this.bookStatusIndex,
    );
  }
}
