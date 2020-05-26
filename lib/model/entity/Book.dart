class Book {
  final String url;
  final String title;
  final String thumbnailUrl;
  final String author;

  /// 0: UNKNOWN, 1: ONGOING, 2: DONE
  final int status;
  final String genre;
  final String description;

  Book({this.url, this.title, this.thumbnailUrl, this.author, this.status = 2, this.genre, this.description});
}
