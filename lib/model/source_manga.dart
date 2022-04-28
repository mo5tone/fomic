import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_manga.freezed.dart';

enum SourceMangaStatus {
  unknown,
  ongoing,
  completed,
  licensed,
  publishingFinished,
  cancelled,
}

@freezed
class SourceManga with _$SourceManga {
  factory SourceManga(
    String key,
    String title, {
    @Default('') String artist,
    @Default('') String author,
    @Default('') String description,
    @Default([]) List<String> genres,
    @Default(SourceMangaStatus.unknown) SourceMangaStatus status,
    @Default('') String cover,
  }) = _SourceManga;
}

extension SourceMangaInfoStatusExtension on SourceMangaStatus {
  Widget icon({
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
  }) {
    var assetName = 'assets/images/vector_drawable/';
    switch (this) {
      case SourceMangaStatus.ongoing:
        assetName += 'ic_status_ongoing.xml';
        break;
      case SourceMangaStatus.completed:
        assetName += 'ic_status_completed.xml';
        break;
      case SourceMangaStatus.licensed:
        assetName += 'ic_status_licensed.xml';
        break;
      default:
        assetName += 'ic_status_unknown.xml';
        break;
    }
    return AvdPicture.asset(
      assetName,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
    );
  }
}
