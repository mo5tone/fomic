import 'package:fomic/sources/base/source.dart';

class Page {
  Source source;
  int index;
  String url;
  String imageUrl;
  Map<String, String> headers = {};

  @override
  String toString() {
    return '''
    {
      source: ${source.runtimeType},
      index: $index,
      url: $url,
      imageUrl: $imageUrl,
      headers: $headers,
    }
    ''';
  }
}
