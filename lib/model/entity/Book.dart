class Book {
  static const unknown = 0;
  static const ongoing = 1;
  static const completed = 2;
  static const licensed = 3;

  final String url;
  String title;
  String thumbnailUrl;
  Map<String, dynamic> thumbnailHeaders;
  String author;
  int status;
  String genre;
  String description;

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
