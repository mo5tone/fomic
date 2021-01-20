import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book with EquatableMixin {
  static const unknown = 0;
  static const ongoing = 1;
  static const completed = 2;
  static const licensed = 3;

  @HiveField(0)
  final String url;
  @HiveField(1)
  String title;
  @HiveField(2)
  String thumbnailUrl;
  @HiveField(3)
  Map<String, dynamic> thumbnailHeaders;
  @HiveField(4)
  String author;
  @HiveField(5)
  int status;
  @HiveField(6)
  String genre;
  @HiveField(7)
  String description;

  @override
  List<Object> get props => [url];

  Book(
    this.url, {
    this.title,
    this.thumbnailUrl,
    this.thumbnailHeaders,
    this.author,
    this.status = 0,
    this.genre,
    this.description,
  });
}

extension BookStatusEx on int {
  String get description {
    switch (this) {
      case 1:
        return 'Ongoing';
      case 2:
        return 'Completed';
      case 3:
        return 'Licensed';
      default:
        return 'Unknown';
    }
  }
}
