import 'package:fomic/model/entity/ImageRequest.dart';

enum SerializingStatus { unknown, ongoing, done }

class Book {
  final String url;
  final String title;
  final ImageRequest thumbnailRequest;
  final String author;
  final SerializingStatus status;
  final String genre;
  final String description;

  Book({
    this.url,
    this.title,
    this.thumbnailRequest,
    this.author,
    this.status = SerializingStatus.done,
    this.genre,
    this.description,
  });

  Book merge(Book other) {
    return Book(
      url: url ?? other.url,
      title: title ?? other.title,
      thumbnailRequest: thumbnailRequest ?? other.thumbnailRequest,
      author: author ?? other.author,
      status: status ?? other.status,
      genre: genre ?? other.genre,
      description: description ?? other.description,
    );
  }
}

extension SerializingStatusEx on SerializingStatus {
  String get rawValue {
    switch (this) {
      case SerializingStatus.ongoing:
        return '连载中';
      case SerializingStatus.done:
        return '已完结';
      default:
        return '未知';
    }
  }
}
