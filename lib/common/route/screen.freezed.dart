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

  ScreenMangaDetail mangaInfo(MangaInfo manga) {
    return ScreenMangaDetail(
      manga,
    );
  }

  ScreenReader chapterInfo(ChapterInfo chapter) {
    return ScreenReader(
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
    required TResult Function(ScreenMangaDetail value) mangaInfo,
    required TResult Function(ScreenReader value) chapterInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScreenMangaDetail value)? mangaInfo,
    TResult Function(ScreenReader value)? chapterInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScreenMangaDetail value)? mangaInfo,
    TResult Function(ScreenReader value)? chapterInfo,
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
abstract class $ScreenMangaDetailCopyWith<$Res> {
  factory $ScreenMangaDetailCopyWith(
          ScreenMangaDetail value, $Res Function(ScreenMangaDetail) then) =
      _$ScreenMangaDetailCopyWithImpl<$Res>;
  $Res call({MangaInfo manga});

  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class _$ScreenMangaDetailCopyWithImpl<$Res> extends _$ScreenCopyWithImpl<$Res>
    implements $ScreenMangaDetailCopyWith<$Res> {
  _$ScreenMangaDetailCopyWithImpl(
      ScreenMangaDetail _value, $Res Function(ScreenMangaDetail) _then)
      : super(_value, (v) => _then(v as ScreenMangaDetail));

  @override
  ScreenMangaDetail get _value => super._value as ScreenMangaDetail;

  @override
  $Res call({
    Object? manga = freezed,
  }) {
    return _then(ScreenMangaDetail(
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

class _$ScreenMangaDetail extends ScreenMangaDetail
    with DiagnosticableTreeMixin {
  _$ScreenMangaDetail(this.manga) : super._();

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
            other is ScreenMangaDetail &&
            const DeepCollectionEquality().equals(other.manga, manga));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(manga));

  @JsonKey(ignore: true)
  @override
  $ScreenMangaDetailCopyWith<ScreenMangaDetail> get copyWith =>
      _$ScreenMangaDetailCopyWithImpl<ScreenMangaDetail>(this, _$identity);

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
    required TResult Function(ScreenMangaDetail value) mangaInfo,
    required TResult Function(ScreenReader value) chapterInfo,
  }) {
    return mangaInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScreenMangaDetail value)? mangaInfo,
    TResult Function(ScreenReader value)? chapterInfo,
  }) {
    return mangaInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScreenMangaDetail value)? mangaInfo,
    TResult Function(ScreenReader value)? chapterInfo,
    required TResult orElse(),
  }) {
    if (mangaInfo != null) {
      return mangaInfo(this);
    }
    return orElse();
  }
}

abstract class ScreenMangaDetail extends Screen {
  factory ScreenMangaDetail(MangaInfo manga) = _$ScreenMangaDetail;
  ScreenMangaDetail._() : super._();

  MangaInfo get manga;
  @JsonKey(ignore: true)
  $ScreenMangaDetailCopyWith<ScreenMangaDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenReaderCopyWith<$Res> {
  factory $ScreenReaderCopyWith(
          ScreenReader value, $Res Function(ScreenReader) then) =
      _$ScreenReaderCopyWithImpl<$Res>;
  $Res call({ChapterInfo chapter});

  $ChapterInfoCopyWith<$Res> get chapter;
}

/// @nodoc
class _$ScreenReaderCopyWithImpl<$Res> extends _$ScreenCopyWithImpl<$Res>
    implements $ScreenReaderCopyWith<$Res> {
  _$ScreenReaderCopyWithImpl(
      ScreenReader _value, $Res Function(ScreenReader) _then)
      : super(_value, (v) => _then(v as ScreenReader));

  @override
  ScreenReader get _value => super._value as ScreenReader;

  @override
  $Res call({
    Object? chapter = freezed,
  }) {
    return _then(ScreenReader(
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

class _$ScreenReader extends ScreenReader with DiagnosticableTreeMixin {
  _$ScreenReader(this.chapter) : super._();

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
            other is ScreenReader &&
            const DeepCollectionEquality().equals(other.chapter, chapter));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(chapter));

  @JsonKey(ignore: true)
  @override
  $ScreenReaderCopyWith<ScreenReader> get copyWith =>
      _$ScreenReaderCopyWithImpl<ScreenReader>(this, _$identity);

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
    required TResult Function(ScreenMangaDetail value) mangaInfo,
    required TResult Function(ScreenReader value) chapterInfo,
  }) {
    return chapterInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScreenMangaDetail value)? mangaInfo,
    TResult Function(ScreenReader value)? chapterInfo,
  }) {
    return chapterInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScreenMangaDetail value)? mangaInfo,
    TResult Function(ScreenReader value)? chapterInfo,
    required TResult orElse(),
  }) {
    if (chapterInfo != null) {
      return chapterInfo(this);
    }
    return orElse();
  }
}

abstract class ScreenReader extends Screen {
  factory ScreenReader(ChapterInfo chapter) = _$ScreenReader;
  ScreenReader._() : super._();

  ChapterInfo get chapter;
  @JsonKey(ignore: true)
  $ScreenReaderCopyWith<ScreenReader> get copyWith =>
      throw _privateConstructorUsedError;
}
