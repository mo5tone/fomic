import 'dart:convert';

import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

@JsonSerializable()
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

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);

  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
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
