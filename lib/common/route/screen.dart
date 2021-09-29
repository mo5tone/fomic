import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/feature/manga_info/view.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen.freezed.dart';

@freezed
class Screen with _$Screen {
  Screen._();
  factory Screen.mangaInfo(MangaInfo manga) = ScreenMangaInfo;

  Route route<T>() => MaterialPageRoute<T>(
        builder: (context) => when(
          mangaInfo: (manga) {
            return MangaInfoView(manga: manga);
          },
        ),
      );
}
