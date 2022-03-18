import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/feature/manga_info/view.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen.freezed.dart';

@freezed
class Screen with _$Screen {
  Screen._();
  factory Screen.mangaInfo(MangaInfo manga) = ScreenMangaInfo;
  factory Screen.chapterInfo(ChapterInfo chapter) = ScreenChapterInfo;

  Future<T?> push<T extends Object>(BuildContext context) {
    final route = MaterialPageRoute<T>(
      builder: (context) {
        return when(
          mangaInfo: (manga) => MangaInfoView(manga: manga),
          chapterInfo: (chapter) => Container(),
        );
      },
    );
    return Navigator.of(context).push(route);
  }
}
