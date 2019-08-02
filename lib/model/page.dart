import 'package:fomic/source/source_id.dart';

class Page {
  SourceID id;
  int index;
  String url;
  String imageUrl;
  Map<String, String> headers = {};

  @override
  String toString() {
    return '''
    {
      id: ${id.index},
      index: $index,
      url: $url,
      imageUrl: $imageUrl,
      headers: $headers,
    }
    ''';
  }
}
