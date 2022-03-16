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
}

/// @nodoc
const $Screen = _$ScreenTearOff();

/// @nodoc
mixin _$Screen {
  MangaInfo get manga => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MangaInfo manga) mangaInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScreenMangaInfo value) mangaInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScreenCopyWith<Screen> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenCopyWith<$Res> {
  factory $ScreenCopyWith(Screen value, $Res Function(Screen) then) =
      _$ScreenCopyWithImpl<$Res>;
  $Res call({MangaInfo manga});

  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class _$ScreenCopyWithImpl<$Res> implements $ScreenCopyWith<$Res> {
  _$ScreenCopyWithImpl(this._value, this._then);

  final Screen _value;
  // ignore: unused_field
  final $Res Function(Screen) _then;

  @override
  $Res call({
    Object? manga = freezed,
  }) {
    return _then(_value.copyWith(
      manga: manga == freezed
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
abstract class $ScreenMangaInfoCopyWith<$Res> implements $ScreenCopyWith<$Res> {
  factory $ScreenMangaInfoCopyWith(
          ScreenMangaInfo value, $Res Function(ScreenMangaInfo) then) =
      _$ScreenMangaInfoCopyWithImpl<$Res>;
  @override
  $Res call({MangaInfo manga});

  @override
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
  }) {
    return mangaInfo(manga);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
  }) {
    return mangaInfo?.call(manga);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MangaInfo manga)? mangaInfo,
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
  }) {
    return mangaInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
  }) {
    return mangaInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScreenMangaInfo value)? mangaInfo,
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

  @override
  MangaInfo get manga;
  @override
  @JsonKey(ignore: true)
  $ScreenMangaInfoCopyWith<ScreenMangaInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
