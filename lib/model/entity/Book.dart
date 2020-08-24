import 'package:dio/dio.dart';

class Book {
  static const unknown = 0;
  static const ongoing = 1;
  static const done = 2;
  static const licensed = 3;

  final String url;
  final String title;
  final RequestOptions thumbnail;
  final String author;
  final int status;
  final String genre;
  final String description;

  Book({
    this.url,
    this.title,
    this.thumbnail,
    this.author,
    this.status = 0,
    this.genre,
    this.description,
  });

  Book copyWith({
    Book other,
    String url,
    String title,
    RequestOptions thumbnail,
    String author,
    int status,
    String genre,
    String description,
  }) {
    return Book(
      url: other?.url ?? url ?? this.url,
      title: other?.title ?? title ?? this.title,
      thumbnail: other?.thumbnail ?? thumbnail ?? this.thumbnail,
      author: other?.author ?? author ?? this.author,
      status: other?.status ?? status ?? this.status,
      genre: other?.genre ?? genre ?? this.genre,
      description: other?.description ?? description ?? this.description,
    );
  }
}

extension BookStatusEx on int {
  String get description {
    switch (this) {
      case 1:
        return '连载中';
      case 2:
        return '已完结';
      case 3:
        return '未许可';
      default:
        return '未知';
    }
  }
}
