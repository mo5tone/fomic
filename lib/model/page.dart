import 'package:fomic/common/helper/cloneable.dart';

import 'chapter.dart';

class Page implements Cloneable<Page> {
  final Chapter chapter;
  final int index;
  final String url;
  final String imageUrl;
  final Map<String, String> headers;

  Page({
    this.chapter,
    this.index,
    this.url,
    this.imageUrl,
    this.headers = const {},
  });

  @override
  Page clone({
    Chapter chapter,
    int index,
    String url,
    String imageUrl,
    Map<String, String> headers,
  }) {
    return Page(
      chapter: chapter ?? this.chapter,
      index: index ?? this.index,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      headers: headers ?? this.headers,
    );
  }
}
