class Page {
  final int index;
  final String url;
  String imageUrl;

  Page(this.index, this.url, {this.imageUrl});

  @override
  String toString() {
    return '''
    Page{
      index: $index,
      url: $url,
      imageUrl: $imageUrl,
    }
    ''';
  }
}
