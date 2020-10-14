class Chapter {
  final String url;
  String name;

  /// In milliseconds
  int updatedAt;
  double index;

  Chapter(this.url, {this.index = -1, this.name, this.updatedAt = 0});
}
