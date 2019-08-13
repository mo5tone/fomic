import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/sources/base/source.dart';

class Page implements Cloneable<Page> {
  final SourceId sourceId;
  final int index;
  final String url;
  final String imageUrl;
  final Map<String, String> headers;

  Page({
    this.sourceId,
    this.index,
    this.url,
    this.imageUrl,
    this.headers = const {},
  });

  @override
  Page clone({
    SourceId sourceId,
    int index,
    String url,
    String imageUrl,
    Map<String, String> headers,
  }) {
    return Page(
      sourceId: sourceId ?? this.sourceId,
      index: index ?? this.index,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      headers: headers ?? this.headers,
    );
  }
}
