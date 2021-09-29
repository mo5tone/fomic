// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MangaInfoEventTearOff {
  const _$MangaInfoEventTearOff();

  MangaInfoEventRefresh refresh() {
    return const MangaInfoEventRefresh();
  }

  MangaInfoEventFavorite favorite() {
    return const MangaInfoEventFavorite();
  }
}

/// @nodoc
const $MangaInfoEvent = _$MangaInfoEventTearOff();

/// @nodoc
mixin _$MangaInfoEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() refresh,
    required TResult Function() favorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function()? favorite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MangaInfoEventRefresh value) refresh,
    required TResult Function(MangaInfoEventFavorite value) favorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaInfoEventRefresh value)? refresh,
    TResult Function(MangaInfoEventFavorite value)? favorite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaInfoEventCopyWith<$Res> {
  factory $MangaInfoEventCopyWith(
          MangaInfoEvent value, $Res Function(MangaInfoEvent) then) =
      _$MangaInfoEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$MangaInfoEventCopyWithImpl<$Res>
    implements $MangaInfoEventCopyWith<$Res> {
  _$MangaInfoEventCopyWithImpl(this._value, this._then);

  final MangaInfoEvent _value;
  // ignore: unused_field
  final $Res Function(MangaInfoEvent) _then;
}

/// @nodoc
abstract class $MangaInfoEventRefreshCopyWith<$Res> {
  factory $MangaInfoEventRefreshCopyWith(MangaInfoEventRefresh value,
          $Res Function(MangaInfoEventRefresh) then) =
      _$MangaInfoEventRefreshCopyWithImpl<$Res>;
}

/// @nodoc
class _$MangaInfoEventRefreshCopyWithImpl<$Res>
    extends _$MangaInfoEventCopyWithImpl<$Res>
    implements $MangaInfoEventRefreshCopyWith<$Res> {
  _$MangaInfoEventRefreshCopyWithImpl(
      MangaInfoEventRefresh _value, $Res Function(MangaInfoEventRefresh) _then)
      : super(_value, (v) => _then(v as MangaInfoEventRefresh));

  @override
  MangaInfoEventRefresh get _value => super._value as MangaInfoEventRefresh;
}

/// @nodoc

class _$MangaInfoEventRefresh
    with DiagnosticableTreeMixin
    implements MangaInfoEventRefresh {
  const _$MangaInfoEventRefresh();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaInfoEvent.refresh()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'MangaInfoEvent.refresh'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is MangaInfoEventRefresh);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() refresh,
    required TResult Function() favorite,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function()? favorite,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MangaInfoEventRefresh value) refresh,
    required TResult Function(MangaInfoEventFavorite value) favorite,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaInfoEventRefresh value)? refresh,
    TResult Function(MangaInfoEventFavorite value)? favorite,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class MangaInfoEventRefresh implements MangaInfoEvent {
  const factory MangaInfoEventRefresh() = _$MangaInfoEventRefresh;
}

/// @nodoc
abstract class $MangaInfoEventFavoriteCopyWith<$Res> {
  factory $MangaInfoEventFavoriteCopyWith(MangaInfoEventFavorite value,
          $Res Function(MangaInfoEventFavorite) then) =
      _$MangaInfoEventFavoriteCopyWithImpl<$Res>;
}

/// @nodoc
class _$MangaInfoEventFavoriteCopyWithImpl<$Res>
    extends _$MangaInfoEventCopyWithImpl<$Res>
    implements $MangaInfoEventFavoriteCopyWith<$Res> {
  _$MangaInfoEventFavoriteCopyWithImpl(MangaInfoEventFavorite _value,
      $Res Function(MangaInfoEventFavorite) _then)
      : super(_value, (v) => _then(v as MangaInfoEventFavorite));

  @override
  MangaInfoEventFavorite get _value => super._value as MangaInfoEventFavorite;
}

/// @nodoc

class _$MangaInfoEventFavorite
    with DiagnosticableTreeMixin
    implements MangaInfoEventFavorite {
  const _$MangaInfoEventFavorite();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaInfoEvent.favorite()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'MangaInfoEvent.favorite'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is MangaInfoEventFavorite);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() refresh,
    required TResult Function() favorite,
  }) {
    return favorite();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function()? favorite,
    required TResult orElse(),
  }) {
    if (favorite != null) {
      return favorite();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MangaInfoEventRefresh value) refresh,
    required TResult Function(MangaInfoEventFavorite value) favorite,
  }) {
    return favorite(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaInfoEventRefresh value)? refresh,
    TResult Function(MangaInfoEventFavorite value)? favorite,
    required TResult orElse(),
  }) {
    if (favorite != null) {
      return favorite(this);
    }
    return orElse();
  }
}

abstract class MangaInfoEventFavorite implements MangaInfoEvent {
  const factory MangaInfoEventFavorite() = _$MangaInfoEventFavorite;
}

/// @nodoc
class _$MangaInfoStateTearOff {
  const _$MangaInfoStateTearOff();

  _MangaInfoState call(
      {required MangaInfo manga, List<ChapterInfo> chapters = const []}) {
    return _MangaInfoState(
      manga: manga,
      chapters: chapters,
    );
  }
}

/// @nodoc
const $MangaInfoState = _$MangaInfoStateTearOff();

/// @nodoc
mixin _$MangaInfoState {
  MangaInfo get manga => throw _privateConstructorUsedError;
  List<ChapterInfo> get chapters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MangaInfoStateCopyWith<MangaInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaInfoStateCopyWith<$Res> {
  factory $MangaInfoStateCopyWith(
          MangaInfoState value, $Res Function(MangaInfoState) then) =
      _$MangaInfoStateCopyWithImpl<$Res>;
  $Res call({MangaInfo manga, List<ChapterInfo> chapters});

  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class _$MangaInfoStateCopyWithImpl<$Res>
    implements $MangaInfoStateCopyWith<$Res> {
  _$MangaInfoStateCopyWithImpl(this._value, this._then);

  final MangaInfoState _value;
  // ignore: unused_field
  final $Res Function(MangaInfoState) _then;

  @override
  $Res call({
    Object? manga = freezed,
    Object? chapters = freezed,
  }) {
    return _then(_value.copyWith(
      manga: manga == freezed
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      chapters: chapters == freezed
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<ChapterInfo>,
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
abstract class _$MangaInfoStateCopyWith<$Res>
    implements $MangaInfoStateCopyWith<$Res> {
  factory _$MangaInfoStateCopyWith(
          _MangaInfoState value, $Res Function(_MangaInfoState) then) =
      __$MangaInfoStateCopyWithImpl<$Res>;
  @override
  $Res call({MangaInfo manga, List<ChapterInfo> chapters});

  @override
  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class __$MangaInfoStateCopyWithImpl<$Res>
    extends _$MangaInfoStateCopyWithImpl<$Res>
    implements _$MangaInfoStateCopyWith<$Res> {
  __$MangaInfoStateCopyWithImpl(
      _MangaInfoState _value, $Res Function(_MangaInfoState) _then)
      : super(_value, (v) => _then(v as _MangaInfoState));

  @override
  _MangaInfoState get _value => super._value as _MangaInfoState;

  @override
  $Res call({
    Object? manga = freezed,
    Object? chapters = freezed,
  }) {
    return _then(_MangaInfoState(
      manga: manga == freezed
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      chapters: chapters == freezed
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<ChapterInfo>,
    ));
  }
}

/// @nodoc

class _$_MangaInfoState
    with DiagnosticableTreeMixin
    implements _MangaInfoState {
  const _$_MangaInfoState({required this.manga, this.chapters = const []});

  @override
  final MangaInfo manga;
  @JsonKey(defaultValue: const [])
  @override
  final List<ChapterInfo> chapters;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaInfoState(manga: $manga, chapters: $chapters)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaInfoState'))
      ..add(DiagnosticsProperty('manga', manga))
      ..add(DiagnosticsProperty('chapters', chapters));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MangaInfoState &&
            (identical(other.manga, manga) ||
                const DeepCollectionEquality().equals(other.manga, manga)) &&
            (identical(other.chapters, chapters) ||
                const DeepCollectionEquality()
                    .equals(other.chapters, chapters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(manga) ^
      const DeepCollectionEquality().hash(chapters);

  @JsonKey(ignore: true)
  @override
  _$MangaInfoStateCopyWith<_MangaInfoState> get copyWith =>
      __$MangaInfoStateCopyWithImpl<_MangaInfoState>(this, _$identity);
}

abstract class _MangaInfoState implements MangaInfoState {
  const factory _MangaInfoState(
      {required MangaInfo manga,
      List<ChapterInfo> chapters}) = _$_MangaInfoState;

  @override
  MangaInfo get manga => throw _privateConstructorUsedError;
  @override
  List<ChapterInfo> get chapters => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MangaInfoStateCopyWith<_MangaInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}
