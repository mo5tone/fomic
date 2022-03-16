import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page.freezed.dart';

@freezed
class Page with _$Page {
  const factory Page.url(String url) = PageUrl;
  const factory Page.imageUrl(String url) = PageImageUrl;
  const factory Page.imageBase64(String data) = PageImageBase64;
  const factory Page.text(String text) = PageText;
}
