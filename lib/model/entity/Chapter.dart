class Chapter {
  final String url;
  final String name;

  /// In milliseconds
  final int updatedAt;
  final double index;

  Chapter({this.url, this.index = -1, this.name, this.updatedAt = 0});
}
