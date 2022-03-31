// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChapterInfoEventTearOff {
  const _$ChapterInfoEventTearOff();

  ChapterInfoEventRefresh refresh() {
    return const ChapterInfoEventRefresh();
  }

  ChapterInfoEventFetch fetch(int index) {
    return ChapterInfoEventFetch(
      index,
    );
  }
}

/// @nodoc
const $ChapterInfoEvent = _$ChapterInfoEventTearOff();

/// @nodoc
mixin _$ChapterInfoEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() refresh,
    required TResult Function(int index) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function(int index)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function(int index)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChapterInfoEventRefresh value) refresh,
    required TResult Function(ChapterInfoEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChapterInfoEventRefresh value)? refresh,
    TResult Function(ChapterInfoEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChapterInfoEventRefresh value)? refresh,
    TResult Function(ChapterInfoEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterInfoEventCopyWith<$Res> {
  factory $ChapterInfoEventCopyWith(
          ChapterInfoEvent value, $Res Function(ChapterInfoEvent) then) =
      _$ChapterInfoEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChapterInfoEventCopyWithImpl<$Res>
    implements $ChapterInfoEventCopyWith<$Res> {
  _$ChapterInfoEventCopyWithImpl(this._value, this._then);

  final ChapterInfoEvent _value;
  // ignore: unused_field
  final $Res Function(ChapterInfoEvent) _then;
}

/// @nodoc
abstract class $ChapterInfoEventRefreshCopyWith<$Res> {
  factory $ChapterInfoEventRefreshCopyWith(ChapterInfoEventRefresh value,
          $Res Function(ChapterInfoEventRefresh) then) =
      _$ChapterInfoEventRefreshCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChapterInfoEventRefreshCopyWithImpl<$Res>
    extends _$ChapterInfoEventCopyWithImpl<$Res>
    implements $ChapterInfoEventRefreshCopyWith<$Res> {
  _$ChapterInfoEventRefreshCopyWithImpl(ChapterInfoEventRefresh _value,
      $Res Function(ChapterInfoEventRefresh) _then)
      : super(_value, (v) => _then(v as ChapterInfoEventRefresh));

  @override
  ChapterInfoEventRefresh get _value => super._value as ChapterInfoEventRefresh;
}

/// @nodoc

class _$ChapterInfoEventRefresh
    with DiagnosticableTreeMixin
    implements ChapterInfoEventRefresh {
  const _$ChapterInfoEventRefresh();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterInfoEvent.refresh()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'ChapterInfoEvent.refresh'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChapterInfoEventRefresh);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() refresh,
    required TResult Function(int index) fetch,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function(int index)? fetch,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function(int index)? fetch,
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
    required TResult Function(ChapterInfoEventRefresh value) refresh,
    required TResult Function(ChapterInfoEventFetch value) fetch,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChapterInfoEventRefresh value)? refresh,
    TResult Function(ChapterInfoEventFetch value)? fetch,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChapterInfoEventRefresh value)? refresh,
    TResult Function(ChapterInfoEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class ChapterInfoEventRefresh implements ChapterInfoEvent {
  const factory ChapterInfoEventRefresh() = _$ChapterInfoEventRefresh;
}

/// @nodoc
abstract class $ChapterInfoEventFetchCopyWith<$Res> {
  factory $ChapterInfoEventFetchCopyWith(ChapterInfoEventFetch value,
          $Res Function(ChapterInfoEventFetch) then) =
      _$ChapterInfoEventFetchCopyWithImpl<$Res>;
  $Res call({int index});
}

/// @nodoc
class _$ChapterInfoEventFetchCopyWithImpl<$Res>
    extends _$ChapterInfoEventCopyWithImpl<$Res>
    implements $ChapterInfoEventFetchCopyWith<$Res> {
  _$ChapterInfoEventFetchCopyWithImpl(
      ChapterInfoEventFetch _value, $Res Function(ChapterInfoEventFetch) _then)
      : super(_value, (v) => _then(v as ChapterInfoEventFetch));

  @override
  ChapterInfoEventFetch get _value => super._value as ChapterInfoEventFetch;

  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(ChapterInfoEventFetch(
      index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ChapterInfoEventFetch
    with DiagnosticableTreeMixin
    implements ChapterInfoEventFetch {
  const _$ChapterInfoEventFetch(this.index);

  @override
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterInfoEvent.fetch(index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterInfoEvent.fetch'))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChapterInfoEventFetch &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  $ChapterInfoEventFetchCopyWith<ChapterInfoEventFetch> get copyWith =>
      _$ChapterInfoEventFetchCopyWithImpl<ChapterInfoEventFetch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() refresh,
    required TResult Function(int index) fetch,
  }) {
    return fetch(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function(int index)? fetch,
  }) {
    return fetch?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? refresh,
    TResult Function(int index)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChapterInfoEventRefresh value) refresh,
    required TResult Function(ChapterInfoEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChapterInfoEventRefresh value)? refresh,
    TResult Function(ChapterInfoEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChapterInfoEventRefresh value)? refresh,
    TResult Function(ChapterInfoEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class ChapterInfoEventFetch implements ChapterInfoEvent {
  const factory ChapterInfoEventFetch(int index) = _$ChapterInfoEventFetch;

  int get index;
  @JsonKey(ignore: true)
  $ChapterInfoEventFetchCopyWith<ChapterInfoEventFetch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ChapterInfoStateTearOff {
  const _$ChapterInfoStateTearOff();

  _ChapterInfoState call(
      {required ChapterInfo chapter,
      int axis = 0,
      int index = 0,
      List<Page> pages = const []}) {
    return _ChapterInfoState(
      chapter: chapter,
      axis: axis,
      index: index,
      pages: pages,
    );
  }
}

/// @nodoc
const $ChapterInfoState = _$ChapterInfoStateTearOff();

/// @nodoc
mixin _$ChapterInfoState {
  ChapterInfo get chapter => throw _privateConstructorUsedError;
  int get axis => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  List<Page> get pages => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChapterInfoStateCopyWith<ChapterInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterInfoStateCopyWith<$Res> {
  factory $ChapterInfoStateCopyWith(
          ChapterInfoState value, $Res Function(ChapterInfoState) then) =
      _$ChapterInfoStateCopyWithImpl<$Res>;
  $Res call({ChapterInfo chapter, int axis, int index, List<Page> pages});

  $ChapterInfoCopyWith<$Res> get chapter;
}

/// @nodoc
class _$ChapterInfoStateCopyWithImpl<$Res>
    implements $ChapterInfoStateCopyWith<$Res> {
  _$ChapterInfoStateCopyWithImpl(this._value, this._then);

  final ChapterInfoState _value;
  // ignore: unused_field
  final $Res Function(ChapterInfoState) _then;

  @override
  $Res call({
    Object? chapter = freezed,
    Object? axis = freezed,
    Object? index = freezed,
    Object? pages = freezed,
  }) {
    return _then(_value.copyWith(
      chapter: chapter == freezed
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as ChapterInfo,
      axis: axis == freezed
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as int,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      pages: pages == freezed
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Page>,
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
abstract class _$ChapterInfoStateCopyWith<$Res>
    implements $ChapterInfoStateCopyWith<$Res> {
  factory _$ChapterInfoStateCopyWith(
          _ChapterInfoState value, $Res Function(_ChapterInfoState) then) =
      __$ChapterInfoStateCopyWithImpl<$Res>;
  @override
  $Res call({ChapterInfo chapter, int axis, int index, List<Page> pages});

  @override
  $ChapterInfoCopyWith<$Res> get chapter;
}

/// @nodoc
class __$ChapterInfoStateCopyWithImpl<$Res>
    extends _$ChapterInfoStateCopyWithImpl<$Res>
    implements _$ChapterInfoStateCopyWith<$Res> {
  __$ChapterInfoStateCopyWithImpl(
      _ChapterInfoState _value, $Res Function(_ChapterInfoState) _then)
      : super(_value, (v) => _then(v as _ChapterInfoState));

  @override
  _ChapterInfoState get _value => super._value as _ChapterInfoState;

  @override
  $Res call({
    Object? chapter = freezed,
    Object? axis = freezed,
    Object? index = freezed,
    Object? pages = freezed,
  }) {
    return _then(_ChapterInfoState(
      chapter: chapter == freezed
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as ChapterInfo,
      axis: axis == freezed
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as int,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      pages: pages == freezed
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Page>,
    ));
  }
}

/// @nodoc

class _$_ChapterInfoState
    with DiagnosticableTreeMixin
    implements _ChapterInfoState {
  const _$_ChapterInfoState(
      {required this.chapter,
      this.axis = 0,
      this.index = 0,
      this.pages = const []});

  @override
  final ChapterInfo chapter;
  @JsonKey()
  @override
  final int axis;
  @JsonKey()
  @override
  final int index;
  @JsonKey()
  @override
  final List<Page> pages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterInfoState(chapter: $chapter, axis: $axis, index: $index, pages: $pages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterInfoState'))
      ..add(DiagnosticsProperty('chapter', chapter))
      ..add(DiagnosticsProperty('axis', axis))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('pages', pages));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChapterInfoState &&
            const DeepCollectionEquality().equals(other.chapter, chapter) &&
            const DeepCollectionEquality().equals(other.axis, axis) &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.pages, pages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chapter),
      const DeepCollectionEquality().hash(axis),
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(pages));

  @JsonKey(ignore: true)
  @override
  _$ChapterInfoStateCopyWith<_ChapterInfoState> get copyWith =>
      __$ChapterInfoStateCopyWithImpl<_ChapterInfoState>(this, _$identity);
}

abstract class _ChapterInfoState implements ChapterInfoState {
  const factory _ChapterInfoState(
      {required ChapterInfo chapter,
      int axis,
      int index,
      List<Page> pages}) = _$_ChapterInfoState;

  @override
  ChapterInfo get chapter;
  @override
  int get axis;
  @override
  int get index;
  @override
  List<Page> get pages;
  @override
  @JsonKey(ignore: true)
  _$ChapterInfoStateCopyWith<_ChapterInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}
