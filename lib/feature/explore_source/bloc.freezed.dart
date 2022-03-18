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
class _$ExploreSourceEventTearOff {
  const _$ExploreSourceEventTearOff();

  ExploreSourceEventLoad load() {
    return const ExploreSourceEventLoad();
  }

  ExploreSourceEventRefresh refresh() {
    return const ExploreSourceEventRefresh();
  }

  ExploreSourceEventSearch search(String query) {
    return ExploreSourceEventSearch(
      query,
    );
  }

  ExploreSourceEventFilter filter(List<Filter> filters) {
    return ExploreSourceEventFilter(
      filters,
    );
  }
}

/// @nodoc
const $ExploreSourceEvent = _$ExploreSourceEventTearOff();

/// @nodoc
mixin _$ExploreSourceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function(String query) search,
    required TResult Function(List<Filter> filters) filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreSourceEventLoad value) load,
    required TResult Function(ExploreSourceEventRefresh value) refresh,
    required TResult Function(ExploreSourceEventSearch value) search,
    required TResult Function(ExploreSourceEventFilter value) filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreSourceEventCopyWith<$Res> {
  factory $ExploreSourceEventCopyWith(
          ExploreSourceEvent value, $Res Function(ExploreSourceEvent) then) =
      _$ExploreSourceEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ExploreSourceEventCopyWithImpl<$Res>
    implements $ExploreSourceEventCopyWith<$Res> {
  _$ExploreSourceEventCopyWithImpl(this._value, this._then);

  final ExploreSourceEvent _value;
  // ignore: unused_field
  final $Res Function(ExploreSourceEvent) _then;
}

/// @nodoc
abstract class $ExploreSourceEventLoadCopyWith<$Res> {
  factory $ExploreSourceEventLoadCopyWith(ExploreSourceEventLoad value,
          $Res Function(ExploreSourceEventLoad) then) =
      _$ExploreSourceEventLoadCopyWithImpl<$Res>;
}

/// @nodoc
class _$ExploreSourceEventLoadCopyWithImpl<$Res>
    extends _$ExploreSourceEventCopyWithImpl<$Res>
    implements $ExploreSourceEventLoadCopyWith<$Res> {
  _$ExploreSourceEventLoadCopyWithImpl(ExploreSourceEventLoad _value,
      $Res Function(ExploreSourceEventLoad) _then)
      : super(_value, (v) => _then(v as ExploreSourceEventLoad));

  @override
  ExploreSourceEventLoad get _value => super._value as ExploreSourceEventLoad;
}

/// @nodoc

class _$ExploreSourceEventLoad
    with DiagnosticableTreeMixin
    implements ExploreSourceEventLoad {
  const _$ExploreSourceEventLoad();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreSourceEvent.load()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'ExploreSourceEvent.load'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExploreSourceEventLoad);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function(String query) search,
    required TResult Function(List<Filter> filters) filter,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
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
    required TResult Function(ExploreSourceEventLoad value) load,
    required TResult Function(ExploreSourceEventRefresh value) refresh,
    required TResult Function(ExploreSourceEventSearch value) search,
    required TResult Function(ExploreSourceEventFilter value) filter,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class ExploreSourceEventLoad implements ExploreSourceEvent {
  const factory ExploreSourceEventLoad() = _$ExploreSourceEventLoad;
}

/// @nodoc
abstract class $ExploreSourceEventRefreshCopyWith<$Res> {
  factory $ExploreSourceEventRefreshCopyWith(ExploreSourceEventRefresh value,
          $Res Function(ExploreSourceEventRefresh) then) =
      _$ExploreSourceEventRefreshCopyWithImpl<$Res>;
}

/// @nodoc
class _$ExploreSourceEventRefreshCopyWithImpl<$Res>
    extends _$ExploreSourceEventCopyWithImpl<$Res>
    implements $ExploreSourceEventRefreshCopyWith<$Res> {
  _$ExploreSourceEventRefreshCopyWithImpl(ExploreSourceEventRefresh _value,
      $Res Function(ExploreSourceEventRefresh) _then)
      : super(_value, (v) => _then(v as ExploreSourceEventRefresh));

  @override
  ExploreSourceEventRefresh get _value =>
      super._value as ExploreSourceEventRefresh;
}

/// @nodoc

class _$ExploreSourceEventRefresh
    with DiagnosticableTreeMixin
    implements ExploreSourceEventRefresh {
  const _$ExploreSourceEventRefresh();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreSourceEvent.refresh()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'ExploreSourceEvent.refresh'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExploreSourceEventRefresh);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function(String query) search,
    required TResult Function(List<Filter> filters) filter,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
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
    required TResult Function(ExploreSourceEventLoad value) load,
    required TResult Function(ExploreSourceEventRefresh value) refresh,
    required TResult Function(ExploreSourceEventSearch value) search,
    required TResult Function(ExploreSourceEventFilter value) filter,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class ExploreSourceEventRefresh implements ExploreSourceEvent {
  const factory ExploreSourceEventRefresh() = _$ExploreSourceEventRefresh;
}

/// @nodoc
abstract class $ExploreSourceEventSearchCopyWith<$Res> {
  factory $ExploreSourceEventSearchCopyWith(ExploreSourceEventSearch value,
          $Res Function(ExploreSourceEventSearch) then) =
      _$ExploreSourceEventSearchCopyWithImpl<$Res>;
  $Res call({String query});
}

/// @nodoc
class _$ExploreSourceEventSearchCopyWithImpl<$Res>
    extends _$ExploreSourceEventCopyWithImpl<$Res>
    implements $ExploreSourceEventSearchCopyWith<$Res> {
  _$ExploreSourceEventSearchCopyWithImpl(ExploreSourceEventSearch _value,
      $Res Function(ExploreSourceEventSearch) _then)
      : super(_value, (v) => _then(v as ExploreSourceEventSearch));

  @override
  ExploreSourceEventSearch get _value =>
      super._value as ExploreSourceEventSearch;

  @override
  $Res call({
    Object? query = freezed,
  }) {
    return _then(ExploreSourceEventSearch(
      query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ExploreSourceEventSearch
    with DiagnosticableTreeMixin
    implements ExploreSourceEventSearch {
  const _$ExploreSourceEventSearch(this.query);

  @override
  final String query;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreSourceEvent.search(query: $query)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExploreSourceEvent.search'))
      ..add(DiagnosticsProperty('query', query));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExploreSourceEventSearch &&
            const DeepCollectionEquality().equals(other.query, query));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(query));

  @JsonKey(ignore: true)
  @override
  $ExploreSourceEventSearchCopyWith<ExploreSourceEventSearch> get copyWith =>
      _$ExploreSourceEventSearchCopyWithImpl<ExploreSourceEventSearch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function(String query) search,
    required TResult Function(List<Filter> filters) filter,
  }) {
    return search(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
  }) {
    return search?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreSourceEventLoad value) load,
    required TResult Function(ExploreSourceEventRefresh value) refresh,
    required TResult Function(ExploreSourceEventSearch value) search,
    required TResult Function(ExploreSourceEventFilter value) filter,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class ExploreSourceEventSearch implements ExploreSourceEvent {
  const factory ExploreSourceEventSearch(String query) =
      _$ExploreSourceEventSearch;

  String get query;
  @JsonKey(ignore: true)
  $ExploreSourceEventSearchCopyWith<ExploreSourceEventSearch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreSourceEventFilterCopyWith<$Res> {
  factory $ExploreSourceEventFilterCopyWith(ExploreSourceEventFilter value,
          $Res Function(ExploreSourceEventFilter) then) =
      _$ExploreSourceEventFilterCopyWithImpl<$Res>;
  $Res call({List<Filter> filters});
}

/// @nodoc
class _$ExploreSourceEventFilterCopyWithImpl<$Res>
    extends _$ExploreSourceEventCopyWithImpl<$Res>
    implements $ExploreSourceEventFilterCopyWith<$Res> {
  _$ExploreSourceEventFilterCopyWithImpl(ExploreSourceEventFilter _value,
      $Res Function(ExploreSourceEventFilter) _then)
      : super(_value, (v) => _then(v as ExploreSourceEventFilter));

  @override
  ExploreSourceEventFilter get _value =>
      super._value as ExploreSourceEventFilter;

  @override
  $Res call({
    Object? filters = freezed,
  }) {
    return _then(ExploreSourceEventFilter(
      filters == freezed
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<Filter>,
    ));
  }
}

/// @nodoc

class _$ExploreSourceEventFilter
    with DiagnosticableTreeMixin
    implements ExploreSourceEventFilter {
  const _$ExploreSourceEventFilter(this.filters);

  @override
  final List<Filter> filters;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreSourceEvent.filter(filters: $filters)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExploreSourceEvent.filter'))
      ..add(DiagnosticsProperty('filters', filters));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExploreSourceEventFilter &&
            const DeepCollectionEquality().equals(other.filters, filters));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(filters));

  @JsonKey(ignore: true)
  @override
  $ExploreSourceEventFilterCopyWith<ExploreSourceEventFilter> get copyWith =>
      _$ExploreSourceEventFilterCopyWithImpl<ExploreSourceEventFilter>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function(String query) search,
    required TResult Function(List<Filter> filters) filter,
  }) {
    return filter(filters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
  }) {
    return filter?.call(filters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function(String query)? search,
    TResult Function(List<Filter> filters)? filter,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(filters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreSourceEventLoad value) load,
    required TResult Function(ExploreSourceEventRefresh value) refresh,
    required TResult Function(ExploreSourceEventSearch value) search,
    required TResult Function(ExploreSourceEventFilter value) filter,
  }) {
    return filter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
  }) {
    return filter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreSourceEventLoad value)? load,
    TResult Function(ExploreSourceEventRefresh value)? refresh,
    TResult Function(ExploreSourceEventSearch value)? search,
    TResult Function(ExploreSourceEventFilter value)? filter,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(this);
    }
    return orElse();
  }
}

abstract class ExploreSourceEventFilter implements ExploreSourceEvent {
  const factory ExploreSourceEventFilter(List<Filter> filters) =
      _$ExploreSourceEventFilter;

  List<Filter> get filters;
  @JsonKey(ignore: true)
  $ExploreSourceEventFilterCopyWith<ExploreSourceEventFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ExploreSourceStateTearOff {
  const _$ExploreSourceStateTearOff();

  _ExploreSourceState call(
      {String query = '',
      List<Filter> filters = const [],
      List<MangasPage> pages = const []}) {
    return _ExploreSourceState(
      query: query,
      filters: filters,
      pages: pages,
    );
  }
}

/// @nodoc
const $ExploreSourceState = _$ExploreSourceStateTearOff();

/// @nodoc
mixin _$ExploreSourceState {
  String get query => throw _privateConstructorUsedError;
  List<Filter> get filters => throw _privateConstructorUsedError;
  List<MangasPage> get pages => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExploreSourceStateCopyWith<ExploreSourceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreSourceStateCopyWith<$Res> {
  factory $ExploreSourceStateCopyWith(
          ExploreSourceState value, $Res Function(ExploreSourceState) then) =
      _$ExploreSourceStateCopyWithImpl<$Res>;
  $Res call({String query, List<Filter> filters, List<MangasPage> pages});
}

/// @nodoc
class _$ExploreSourceStateCopyWithImpl<$Res>
    implements $ExploreSourceStateCopyWith<$Res> {
  _$ExploreSourceStateCopyWithImpl(this._value, this._then);

  final ExploreSourceState _value;
  // ignore: unused_field
  final $Res Function(ExploreSourceState) _then;

  @override
  $Res call({
    Object? query = freezed,
    Object? filters = freezed,
    Object? pages = freezed,
  }) {
    return _then(_value.copyWith(
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      filters: filters == freezed
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<Filter>,
      pages: pages == freezed
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<MangasPage>,
    ));
  }
}

/// @nodoc
abstract class _$ExploreSourceStateCopyWith<$Res>
    implements $ExploreSourceStateCopyWith<$Res> {
  factory _$ExploreSourceStateCopyWith(
          _ExploreSourceState value, $Res Function(_ExploreSourceState) then) =
      __$ExploreSourceStateCopyWithImpl<$Res>;
  @override
  $Res call({String query, List<Filter> filters, List<MangasPage> pages});
}

/// @nodoc
class __$ExploreSourceStateCopyWithImpl<$Res>
    extends _$ExploreSourceStateCopyWithImpl<$Res>
    implements _$ExploreSourceStateCopyWith<$Res> {
  __$ExploreSourceStateCopyWithImpl(
      _ExploreSourceState _value, $Res Function(_ExploreSourceState) _then)
      : super(_value, (v) => _then(v as _ExploreSourceState));

  @override
  _ExploreSourceState get _value => super._value as _ExploreSourceState;

  @override
  $Res call({
    Object? query = freezed,
    Object? filters = freezed,
    Object? pages = freezed,
  }) {
    return _then(_ExploreSourceState(
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      filters: filters == freezed
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<Filter>,
      pages: pages == freezed
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<MangasPage>,
    ));
  }
}

/// @nodoc

class _$_ExploreSourceState
    with DiagnosticableTreeMixin
    implements _ExploreSourceState {
  const _$_ExploreSourceState(
      {this.query = '', this.filters = const [], this.pages = const []});

  @JsonKey()
  @override
  final String query;
  @JsonKey()
  @override
  final List<Filter> filters;
  @JsonKey()
  @override
  final List<MangasPage> pages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreSourceState(query: $query, filters: $filters, pages: $pages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExploreSourceState'))
      ..add(DiagnosticsProperty('query', query))
      ..add(DiagnosticsProperty('filters', filters))
      ..add(DiagnosticsProperty('pages', pages));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExploreSourceState &&
            const DeepCollectionEquality().equals(other.query, query) &&
            const DeepCollectionEquality().equals(other.filters, filters) &&
            const DeepCollectionEquality().equals(other.pages, pages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(query),
      const DeepCollectionEquality().hash(filters),
      const DeepCollectionEquality().hash(pages));

  @JsonKey(ignore: true)
  @override
  _$ExploreSourceStateCopyWith<_ExploreSourceState> get copyWith =>
      __$ExploreSourceStateCopyWithImpl<_ExploreSourceState>(this, _$identity);
}

abstract class _ExploreSourceState implements ExploreSourceState {
  const factory _ExploreSourceState(
      {String query,
      List<Filter> filters,
      List<MangasPage> pages}) = _$_ExploreSourceState;

  @override
  String get query;
  @override
  List<Filter> get filters;
  @override
  List<MangasPage> get pages;
  @override
  @JsonKey(ignore: true)
  _$ExploreSourceStateCopyWith<_ExploreSourceState> get copyWith =>
      throw _privateConstructorUsedError;
}
