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
class _$SourceMangasEventTearOff {
  const _$SourceMangasEventTearOff();

  SourceMangasEventLoad load() {
    return const SourceMangasEventLoad();
  }

  SourceMangasEventRefresh refresh() {
    return const SourceMangasEventRefresh();
  }
}

/// @nodoc
const $SourceMangasEvent = _$SourceMangasEventTearOff();

/// @nodoc
mixin _$SourceMangasEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMangasEventLoad value) load,
    required TResult Function(SourceMangasEventRefresh value) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMangasEventLoad value)? load,
    TResult Function(SourceMangasEventRefresh value)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceMangasEventCopyWith<$Res> {
  factory $SourceMangasEventCopyWith(
          SourceMangasEvent value, $Res Function(SourceMangasEvent) then) =
      _$SourceMangasEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SourceMangasEventCopyWithImpl<$Res>
    implements $SourceMangasEventCopyWith<$Res> {
  _$SourceMangasEventCopyWithImpl(this._value, this._then);

  final SourceMangasEvent _value;
  // ignore: unused_field
  final $Res Function(SourceMangasEvent) _then;
}

/// @nodoc
abstract class $SourceMangasEventLoadCopyWith<$Res> {
  factory $SourceMangasEventLoadCopyWith(SourceMangasEventLoad value,
          $Res Function(SourceMangasEventLoad) then) =
      _$SourceMangasEventLoadCopyWithImpl<$Res>;
}

/// @nodoc
class _$SourceMangasEventLoadCopyWithImpl<$Res>
    extends _$SourceMangasEventCopyWithImpl<$Res>
    implements $SourceMangasEventLoadCopyWith<$Res> {
  _$SourceMangasEventLoadCopyWithImpl(
      SourceMangasEventLoad _value, $Res Function(SourceMangasEventLoad) _then)
      : super(_value, (v) => _then(v as SourceMangasEventLoad));

  @override
  SourceMangasEventLoad get _value => super._value as SourceMangasEventLoad;
}

/// @nodoc

class _$SourceMangasEventLoad
    with DiagnosticableTreeMixin
    implements SourceMangasEventLoad {
  const _$SourceMangasEventLoad();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SourceMangasEvent.load()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'SourceMangasEvent.load'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SourceMangasEventLoad);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMangasEventLoad value) load,
    required TResult Function(SourceMangasEventRefresh value) refresh,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMangasEventLoad value)? load,
    TResult Function(SourceMangasEventRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class SourceMangasEventLoad implements SourceMangasEvent {
  const factory SourceMangasEventLoad() = _$SourceMangasEventLoad;
}

/// @nodoc
abstract class $SourceMangasEventRefreshCopyWith<$Res> {
  factory $SourceMangasEventRefreshCopyWith(SourceMangasEventRefresh value,
          $Res Function(SourceMangasEventRefresh) then) =
      _$SourceMangasEventRefreshCopyWithImpl<$Res>;
}

/// @nodoc
class _$SourceMangasEventRefreshCopyWithImpl<$Res>
    extends _$SourceMangasEventCopyWithImpl<$Res>
    implements $SourceMangasEventRefreshCopyWith<$Res> {
  _$SourceMangasEventRefreshCopyWithImpl(SourceMangasEventRefresh _value,
      $Res Function(SourceMangasEventRefresh) _then)
      : super(_value, (v) => _then(v as SourceMangasEventRefresh));

  @override
  SourceMangasEventRefresh get _value =>
      super._value as SourceMangasEventRefresh;
}

/// @nodoc

class _$SourceMangasEventRefresh
    with DiagnosticableTreeMixin
    implements SourceMangasEventRefresh {
  const _$SourceMangasEventRefresh();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SourceMangasEvent.refresh()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'SourceMangasEvent.refresh'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SourceMangasEventRefresh);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
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
    required TResult Function(SourceMangasEventLoad value) load,
    required TResult Function(SourceMangasEventRefresh value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMangasEventLoad value)? load,
    TResult Function(SourceMangasEventRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class SourceMangasEventRefresh implements SourceMangasEvent {
  const factory SourceMangasEventRefresh() = _$SourceMangasEventRefresh;
}

/// @nodoc
class _$SourceMangasStateTearOff {
  const _$SourceMangasStateTearOff();

  _SourceMangasState call({List<MangasPage> pages = const []}) {
    return _SourceMangasState(
      pages: pages,
    );
  }
}

/// @nodoc
const $SourceMangasState = _$SourceMangasStateTearOff();

/// @nodoc
mixin _$SourceMangasState {
  List<MangasPage> get pages => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SourceMangasStateCopyWith<SourceMangasState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceMangasStateCopyWith<$Res> {
  factory $SourceMangasStateCopyWith(
          SourceMangasState value, $Res Function(SourceMangasState) then) =
      _$SourceMangasStateCopyWithImpl<$Res>;
  $Res call({List<MangasPage> pages});
}

/// @nodoc
class _$SourceMangasStateCopyWithImpl<$Res>
    implements $SourceMangasStateCopyWith<$Res> {
  _$SourceMangasStateCopyWithImpl(this._value, this._then);

  final SourceMangasState _value;
  // ignore: unused_field
  final $Res Function(SourceMangasState) _then;

  @override
  $Res call({
    Object? pages = freezed,
  }) {
    return _then(_value.copyWith(
      pages: pages == freezed
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<MangasPage>,
    ));
  }
}

/// @nodoc
abstract class _$SourceMangasStateCopyWith<$Res>
    implements $SourceMangasStateCopyWith<$Res> {
  factory _$SourceMangasStateCopyWith(
          _SourceMangasState value, $Res Function(_SourceMangasState) then) =
      __$SourceMangasStateCopyWithImpl<$Res>;
  @override
  $Res call({List<MangasPage> pages});
}

/// @nodoc
class __$SourceMangasStateCopyWithImpl<$Res>
    extends _$SourceMangasStateCopyWithImpl<$Res>
    implements _$SourceMangasStateCopyWith<$Res> {
  __$SourceMangasStateCopyWithImpl(
      _SourceMangasState _value, $Res Function(_SourceMangasState) _then)
      : super(_value, (v) => _then(v as _SourceMangasState));

  @override
  _SourceMangasState get _value => super._value as _SourceMangasState;

  @override
  $Res call({
    Object? pages = freezed,
  }) {
    return _then(_SourceMangasState(
      pages: pages == freezed
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<MangasPage>,
    ));
  }
}

/// @nodoc

class _$_SourceMangasState
    with DiagnosticableTreeMixin
    implements _SourceMangasState {
  const _$_SourceMangasState({this.pages = const []});

  @JsonKey(defaultValue: const [])
  @override
  final List<MangasPage> pages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SourceMangasState(pages: $pages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SourceMangasState'))
      ..add(DiagnosticsProperty('pages', pages));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SourceMangasState &&
            (identical(other.pages, pages) ||
                const DeepCollectionEquality().equals(other.pages, pages)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(pages);

  @JsonKey(ignore: true)
  @override
  _$SourceMangasStateCopyWith<_SourceMangasState> get copyWith =>
      __$SourceMangasStateCopyWithImpl<_SourceMangasState>(this, _$identity);
}

abstract class _SourceMangasState implements SourceMangasState {
  const factory _SourceMangasState({List<MangasPage> pages}) =
      _$_SourceMangasState;

  @override
  List<MangasPage> get pages => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SourceMangasStateCopyWith<_SourceMangasState> get copyWith =>
      throw _privateConstructorUsedError;
}
