import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_page.freezed.dart';

@freezed
class SourcePage with _$SourcePage {
  const factory SourcePage.url(String url) = SourcePageUrl;
  const factory SourcePage.imageUrl(String url) = SourcePageImageUrl;
  const factory SourcePage.imageBase64(String data) = SourcePageImageBase64;
  const factory SourcePage.text(String text) = SourcePageText;
}
