// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'screen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ScreenTearOff {
  const _$ScreenTearOff();

  ScreenMangaInfo mangaInfo(MangaInfo manga) {
    return ScreenMangaInfo(
      manga,
    );
  }

  ScreenChapterInfo chapterInfo(ChapterInfo chapter) {
    return ScreenChapterInfo(
      chapter,
    );
  }
}

/// @nodoc
const $Screen = _$ScreenTearOff();

/// @nodoc
mixin _$Screen {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MangaInfo manga) mangaInfo,
    required TResult Function(ChapterInfo chapter) chapterInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
    TResult Function(ChapterInfo chapter)? chapterInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
    TResult Function(ChapterInfo chapter)? chapterInfo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScreenMangaInfo value) mangaInfo,
    required TResult Function(ScreenChapterInfo value) chapterInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
    TResult Function(ScreenChapterInfo value)? chapterInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
    TResult Function(ScreenChapterInfo value)? chapterInfo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenCopyWith<$Res> {
  factory $ScreenCopyWith(Screen value, $Res Function(Screen) then) =
      _$ScreenCopyWithImpl<$Res>;
}

/// @nodoc
class _$ScreenCopyWithImpl<$Res> implements $ScreenCopyWith<$Res> {
  _$ScreenCopyWithImpl(this._value, this._then);

  final Screen _value;
  // ignore: unused_field
  final $Res Function(Screen) _then;
}

/// @nodoc
abstract class $ScreenMangaInfoCopyWith<$Res> {
  factory $ScreenMangaInfoCopyWith(
          ScreenMangaInfo value, $Res Function(ScreenMangaInfo) then) =
      _$ScreenMangaInfoCopyWithImpl<$Res>;
  $Res call({MangaInfo manga});

  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class _$ScreenMangaInfoCopyWithImpl<$Res> extends _$ScreenCopyWithImpl<$Res>
    implements $ScreenMangaInfoCopyWith<$Res> {
  _$ScreenMangaInfoCopyWithImpl(
      ScreenMangaInfo _value, $Res Function(ScreenMangaInfo) _then)
      : super(_value, (v) => _then(v as ScreenMangaInfo));

  @override
  ScreenMangaInfo get _value => super._value as ScreenMangaInfo;

  @override
  $Res call({
    Object? manga = freezed,
  }) {
    return _then(ScreenMangaInfo(
      manga == freezed
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
    ));
  }

  @override
  $MangaInfoCopyWith<$Res> get manga {
    return $MangaInfoCopyWith<$Res>(_value.manga, (value) {
      return _then(_value.copyWith(manga: value));
    });
  }
}

/// @nodoc

class _$ScreenMangaInfo extends ScreenMangaInfo with DiagnosticableTreeMixin {
  _$ScreenMangaInfo(this.manga) : super._();

  @override
  final MangaInfo manga;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Screen.mangaInfo(manga: $manga)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Screen.mangaInfo'))
      ..add(DiagnosticsProperty('manga', manga));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScreenMangaInfo &&
            const DeepCollectionEquality().equals(other.manga, manga));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(manga));

  @JsonKey(ignore: true)
  @override
  $ScreenMangaInfoCopyWith<ScreenMangaInfo> get copyWith =>
      _$ScreenMangaInfoCopyWithImpl<ScreenMangaInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MangaInfo manga) mangaInfo,
    required TResult Function(ChapterInfo chapter) chapterInfo,
  }) {
    return mangaInfo(manga);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
    TResult Function(ChapterInfo chapter)? chapterInfo,
  }) {
    return mangaInfo?.call(manga);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
    TResult Function(ChapterInfo chapter)? chapterInfo,
    required TResult orElse(),
  }) {
    if (mangaInfo != null) {
      return mangaInfo(manga);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScreenMangaInfo value) mangaInfo,
    required TResult Function(ScreenChapterInfo value) chapterInfo,
  }) {
    return mangaInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
    TResult Function(ScreenChapterInfo value)? chapterInfo,
  }) {
    return mangaInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
    TResult Function(ScreenChapterInfo value)? chapterInfo,
    required TResult orElse(),
  }) {
    if (mangaInfo != null) {
      return mangaInfo(this);
    }
    return orElse();
  }
}

abstract class ScreenMangaInfo extends Screen {
  factory ScreenMangaInfo(MangaInfo manga) = _$ScreenMangaInfo;
  ScreenMangaInfo._() : super._();

  MangaInfo get manga;
  @JsonKey(ignore: true)
  $ScreenMangaInfoCopyWith<ScreenMangaInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenChapterInfoCopyWith<$Res> {
  factory $ScreenChapterInfoCopyWith(
          ScreenChapterInfo value, $Res Function(ScreenChapterInfo) then) =
      _$ScreenChapterInfoCopyWithImpl<$Res>;
  $Res call({ChapterInfo chapter});

  $ChapterInfoCopyWith<$Res> get chapter;
}

/// @nodoc
class _$ScreenChapterInfoCopyWithImpl<$Res> extends _$ScreenCopyWithImpl<$Res>
    implements $ScreenChapterInfoCopyWith<$Res> {
  _$ScreenChapterInfoCopyWithImpl(
      ScreenChapterInfo _value, $Res Function(ScreenChapterInfo) _then)
      : super(_value, (v) => _then(v as ScreenChapterInfo));

  @override
  ScreenChapterInfo get _value => super._value as ScreenChapterInfo;

  @override
  $Res call({
    Object? chapter = freezed,
  }) {
    return _then(ScreenChapterInfo(
      chapter == freezed
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as ChapterInfo,
    ));
  }

  @override
  $ChapterInfoCopyWith<$Res> get chapter {
    return $ChapterInfoCopyWith<$Res>(_value.chapter, (value) {
      return _then(_value.copyWith(chapter: value));
    });
  }
}

/// @nodoc

class _$ScreenChapterInfo extends ScreenChapterInfo
    with DiagnosticableTreeMixin {
  _$ScreenChapterInfo(this.chapter) : super._();

  @override
  final ChapterInfo chapter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Screen.chapterInfo(chapter: $chapter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Screen.chapterInfo'))
      ..add(DiagnosticsProperty('chapter', chapter));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScreenChapterInfo &&
            const DeepCollectionEquality().equals(other.chapter, chapter));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(chapter));

  @JsonKey(ignore: true)
  @override
  $ScreenChapterInfoCopyWith<ScreenChapterInfo> get copyWith =>
      _$ScreenChapterInfoCopyWithImpl<ScreenChapterInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MangaInfo manga) mangaInfo,
    required TResult Function(ChapterInfo chapter) chapterInfo,
  }) {
    return chapterInfo(chapter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
    TResult Function(ChapterInfo chapter)? chapterInfo,
  }) {
    return chapterInfo?.call(chapter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
    TResult Function(ChapterInfo chapter)? chapterInfo,
    required TResult orElse(),
  }) {
    if (chapterInfo != null) {
      return chapterInfo(chapter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScreenMangaInfo value) mangaInfo,
    required TResult Function(ScreenChapterInfo value) chapterInfo,
  }) {
    return chapterInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
    TResult Function(ScreenChapterInfo value)? chapterInfo,
  }) {
    return chapterInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
    TResult Function(ScreenChapterInfo value)? chapterInfo,
    required TResult orElse(),
  }) {
    if (chapterInfo != null) {
      return chapterInfo(this);
    }
    return orElse();
  }
}

abstract class ScreenChapterInfo extends Screen {
  factory ScreenChapterInfo(ChapterInfo chapter) = _$ScreenChapterInfo;
  ScreenChapterInfo._() : super._();

  ChapterInfo get chapter;
  @JsonKey(ignore: true)
  $ScreenChapterInfoCopyWith<ScreenChapterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
