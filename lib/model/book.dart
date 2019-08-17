import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/sources/base/source.dart';

enum BookStatus {
  unknown,
  ongoing,
  completed,
  licensed,
}

class Book implements Cloneable<Book> {
  final SourceId sourceId;
  final String url;
  final String thumbnailUrl;
  final String title;
  final String artist;
  final String author;
  final String genre;
  final String description;
  final BookStatus status;

  Book({
    this.sourceId,
    this.url,
    this.thumbnailUrl,
    this.title,
    this.artist,
    this.author,
    this.genre,
    this.description,
    this.status = BookStatus.unknown,
  }) : assert(sourceId != null);

  @override
  Book clone({
    SourceId sourceId,
    String url,
    String thumbnailUrl,
    String title,
    String artist,
    String author,
    String genre,
    String description,
    BookStatus status,
    List<Chapter> chapters,
  }) {
    return Book(
      sourceId: sourceId ?? this.sourceId,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}
