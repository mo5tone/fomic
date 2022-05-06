import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_page.dart';

abstract class Source {
  int get id;
  String get name;

  /// An ISO 639-1 compliant language code (two letters in lower case).
  String get lang;

  int get settingItemCount => 0;

  Widget Function(BuildContext, int)? get settingItemBuilder => null;

  const Source();

  FutureOr<SourceManga> fetchMangaDetails({required SourceManga manga});
  FutureOr<List<SourceChapter>> fetchChapterList({required SourceManga manga});
  FutureOr<List<SourcePage>> fetchPageList({required SourceChapter chapter});
}
