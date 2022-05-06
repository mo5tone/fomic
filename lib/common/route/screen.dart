import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/feature/manga_detail/view.dart';
import 'package:fomic/feature/reader/view.dart';
import 'package:fomic/feature/source_setting/view.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen.freezed.dart';

@freezed
class Screen with _$Screen {
  Screen._();
  factory Screen.sourceSetting() = ScreenSourceSetting;
  factory Screen.mangaDetail(SourceManga manga) = ScreenMangaDetail;
  factory Screen.reader(SourceChapter chapter) = ScreenReader;

  Future<T?> push<T extends Object>(BuildContext context) {
    final route = MaterialPageRoute<T>(builder: _builder);
    return Navigator.of(context).push(route);
  }

  Widget _builder(BuildContext context) {
    return when(
      sourceSetting: () => const SourceSetting(),
      mangaDetail: (manga) => MangaDetailView(manga: manga),
      reader: (chapter) => ReaderView(chapter: chapter),
    );
  }
}
