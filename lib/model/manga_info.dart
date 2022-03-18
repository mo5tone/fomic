import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manga_info.freezed.dart';
part 'manga_info.g.dart';

@HiveType(typeId: 0)
enum MangaInfoStatus {
  @HiveField(0)
  unknown,
  @HiveField(1)
  ongoing,
  @HiveField(2)
  completed,
  @HiveField(3)
  licensed,
  @HiveField(4)
  publishingFinished,
  @HiveField(5)
  cancelled,
  @HiveField(6)
  onHiatus,
}

extension MangaInfoStatusExtension on MangaInfoStatus {
  Widget image({
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
      case MangaInfoStatus.ongoing:
        assetName += 'ic_status_ongoing.xml';
        break;
      case MangaInfoStatus.completed:
        assetName += 'ic_status_completed.xml';
        break;
      case MangaInfoStatus.licensed:
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

@freezed
class MangaInfo with _$MangaInfo {
  factory MangaInfo(
    String key,
    String title, {
    @Default('') String artist,
    @Default('') String author,
    @Default('') String description,
    @Default([]) List<String> genres,
    @Default(MangaInfoStatus.unknown) MangaInfoStatus status,
    @Default('') String cover,
  }) = _MangaInfo;
}
