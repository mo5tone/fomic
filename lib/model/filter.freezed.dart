// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FilterTearOff {
  const _$FilterTearOff();

  FilterHeader header(String name) {
    return FilterHeader(
      name,
    );
  }

  FilterSeparator separator({String name = ''}) {
    return FilterSeparator(
      name: name,
    );
  }

  FilterSelect select(String name, List<String> options, {int state = 0}) {
    return FilterSelect(
      name,
      options,
      state: state,
    );
  }

  FilterText text(String name, {String state = ''}) {
    return FilterText(
      name,
      state: state,
    );
  }

  FilterCheck check(String name, {bool state = false}) {
    return FilterCheck(
      name,
      state: state,
    );
  }

  FilterSort sort(
      String name, List<String> options, int state, bool ascending) {
    return FilterSort(
      name,
      options,
      state,
      ascending,
    );
  }
}

/// @nodoc
const $Filter = _$FilterTearOff();

/// @nodoc
mixin _$Filter {
  String get name => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) header,
    required TResult Function(String name) separator,
    required TResult Function(String name, List<String> options, int state)
        select,
    required TResult Function(String name, String state) text,
    required TResult Function(String name, bool state) check,
    required TResult Function(
            String name, List<String> options, int state, bool ascending)
        sort,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterHeader value) header,
    required TResult Function(FilterSeparator value) separator,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSort value) sort,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FilterCopyWith<Filter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$FilterCopyWithImpl<$Res> implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  final Filter _value;
  // ignore: unused_field
  final $Res Function(Filter) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $FilterHeaderCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterHeaderCopyWith(
          FilterHeader value, $Res Function(FilterHeader) then) =
      _$FilterHeaderCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class _$FilterHeaderCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $FilterHeaderCopyWith<$Res> {
  _$FilterHeaderCopyWithImpl(
      FilterHeader _value, $Res Function(FilterHeader) _then)
      : super(_value, (v) => _then(v as FilterHeader));

  @override
  FilterHeader get _value => super._value as FilterHeader;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(FilterHeader(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterHeader with DiagnosticableTreeMixin implements FilterHeader {
  const _$FilterHeader(this.name);

  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.header(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.header'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterHeader &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  $FilterHeaderCopyWith<FilterHeader> get copyWith =>
      _$FilterHeaderCopyWithImpl<FilterHeader>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) header,
    required TResult Function(String name) separator,
    required TResult Function(String name, List<String> options, int state)
        select,
    required TResult Function(String name, String state) text,
    required TResult Function(String name, bool state) check,
    required TResult Function(
            String name, List<String> options, int state, bool ascending)
        sort,
  }) {
    return header(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
  }) {
    return header?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (header != null) {
      return header(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterHeader value) header,
    required TResult Function(FilterSeparator value) separator,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSort value) sort,
  }) {
    return header(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
  }) {
    return header?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) {
    if (header != null) {
      return header(this);
    }
    return orElse();
  }
}

abstract class FilterHeader implements Filter {
  const factory FilterHeader(String name) = _$FilterHeader;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  $FilterHeaderCopyWith<FilterHeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterSeparatorCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterSeparatorCopyWith(
          FilterSeparator value, $Res Function(FilterSeparator) then) =
      _$FilterSeparatorCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class _$FilterSeparatorCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $FilterSeparatorCopyWith<$Res> {
  _$FilterSeparatorCopyWithImpl(
      FilterSeparator _value, $Res Function(FilterSeparator) _then)
      : super(_value, (v) => _then(v as FilterSeparator));

  @override
  FilterSeparator get _value => super._value as FilterSeparator;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(FilterSeparator(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterSeparator
    with DiagnosticableTreeMixin
    implements FilterSeparator {
  const _$FilterSeparator({this.name = ''});

  @JsonKey()
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.separator(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.separator'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterSeparator &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  $FilterSeparatorCopyWith<FilterSeparator> get copyWith =>
      _$FilterSeparatorCopyWithImpl<FilterSeparator>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) header,
    required TResult Function(String name) separator,
    required TResult Function(String name, List<String> options, int state)
        select,
    required TResult Function(String name, String state) text,
    required TResult Function(String name, bool state) check,
    required TResult Function(
            String name, List<String> options, int state, bool ascending)
        sort,
  }) {
    return separator(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
  }) {
    return separator?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (separator != null) {
      return separator(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterHeader value) header,
    required TResult Function(FilterSeparator value) separator,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSort value) sort,
  }) {
    return separator(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
  }) {
    return separator?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) {
    if (separator != null) {
      return separator(this);
    }
    return orElse();
  }
}

abstract class FilterSeparator implements Filter {
  const factory FilterSeparator({String name}) = _$FilterSeparator;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  $FilterSeparatorCopyWith<FilterSeparator> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterSelectCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterSelectCopyWith(
          FilterSelect value, $Res Function(FilterSelect) then) =
      _$FilterSelectCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<String> options, int state});
}

/// @nodoc
class _$FilterSelectCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $FilterSelectCopyWith<$Res> {
  _$FilterSelectCopyWithImpl(
      FilterSelect _value, $Res Function(FilterSelect) _then)
      : super(_value, (v) => _then(v as FilterSelect));

  @override
  FilterSelect get _value => super._value as FilterSelect;

  @override
  $Res call({
    Object? name = freezed,
    Object? options = freezed,
    Object? state = freezed,
  }) {
    return _then(FilterSelect(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      options == freezed
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FilterSelect with DiagnosticableTreeMixin implements FilterSelect {
  const _$FilterSelect(this.name, this.options, {this.state = 0});

  @override
  final String name;
  @override
  final List<String> options;
  @JsonKey()
  @override
  final int state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.select(name: $name, options: $options, state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.select'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterSelect &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.options, options) &&
            const DeepCollectionEquality().equals(other.state, state));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(options),
      const DeepCollectionEquality().hash(state));

  @JsonKey(ignore: true)
  @override
  $FilterSelectCopyWith<FilterSelect> get copyWith =>
      _$FilterSelectCopyWithImpl<FilterSelect>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) header,
    required TResult Function(String name) separator,
    required TResult Function(String name, List<String> options, int state)
        select,
    required TResult Function(String name, String state) text,
    required TResult Function(String name, bool state) check,
    required TResult Function(
            String name, List<String> options, int state, bool ascending)
        sort,
  }) {
    return select(name, options, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
  }) {
    return select?.call(name, options, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(name, options, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterHeader value) header,
    required TResult Function(FilterSeparator value) separator,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSort value) sort,
  }) {
    return select(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
  }) {
    return select?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(this);
    }
    return orElse();
  }
}

abstract class FilterSelect implements Filter {
  const factory FilterSelect(String name, List<String> options, {int state}) =
      _$FilterSelect;

  @override
  String get name;
  List<String> get options;
  int get state;
  @override
  @JsonKey(ignore: true)
  $FilterSelectCopyWith<FilterSelect> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterTextCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterTextCopyWith(
          FilterText value, $Res Function(FilterText) then) =
      _$FilterTextCopyWithImpl<$Res>;
  @override
  $Res call({String name, String state});
}

/// @nodoc
class _$FilterTextCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $FilterTextCopyWith<$Res> {
  _$FilterTextCopyWithImpl(FilterText _value, $Res Function(FilterText) _then)
      : super(_value, (v) => _then(v as FilterText));

  @override
  FilterText get _value => super._value as FilterText;

  @override
  $Res call({
    Object? name = freezed,
    Object? state = freezed,
  }) {
    return _then(FilterText(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterText with DiagnosticableTreeMixin implements FilterText {
  const _$FilterText(this.name, {this.state = ''});

  @override
  final String name;
  @JsonKey()
  @override
  final String state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.text(name: $name, state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.text'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterText &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.state, state));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(state));

  @JsonKey(ignore: true)
  @override
  $FilterTextCopyWith<FilterText> get copyWith =>
      _$FilterTextCopyWithImpl<FilterText>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) header,
    required TResult Function(String name) separator,
    required TResult Function(String name, List<String> options, int state)
        select,
    required TResult Function(String name, String state) text,
    required TResult Function(String name, bool state) check,
    required TResult Function(
            String name, List<String> options, int state, bool ascending)
        sort,
  }) {
    return text(name, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
  }) {
    return text?.call(name, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(name, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterHeader value) header,
    required TResult Function(FilterSeparator value) separator,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSort value) sort,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class FilterText implements Filter {
  const factory FilterText(String name, {String state}) = _$FilterText;

  @override
  String get name;
  String get state;
  @override
  @JsonKey(ignore: true)
  $FilterTextCopyWith<FilterText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCheckCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterCheckCopyWith(
          FilterCheck value, $Res Function(FilterCheck) then) =
      _$FilterCheckCopyWithImpl<$Res>;
  @override
  $Res call({String name, bool state});
}

/// @nodoc
class _$FilterCheckCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $FilterCheckCopyWith<$Res> {
  _$FilterCheckCopyWithImpl(
      FilterCheck _value, $Res Function(FilterCheck) _then)
      : super(_value, (v) => _then(v as FilterCheck));

  @override
  FilterCheck get _value => super._value as FilterCheck;

  @override
  $Res call({
    Object? name = freezed,
    Object? state = freezed,
  }) {
    return _then(FilterCheck(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FilterCheck with DiagnosticableTreeMixin implements FilterCheck {
  const _$FilterCheck(this.name, {this.state = false});

  @override
  final String name;
  @JsonKey()
  @override
  final bool state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.check(name: $name, state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.check'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterCheck &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.state, state));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(state));

  @JsonKey(ignore: true)
  @override
  $FilterCheckCopyWith<FilterCheck> get copyWith =>
      _$FilterCheckCopyWithImpl<FilterCheck>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) header,
    required TResult Function(String name) separator,
    required TResult Function(String name, List<String> options, int state)
        select,
    required TResult Function(String name, String state) text,
    required TResult Function(String name, bool state) check,
    required TResult Function(
            String name, List<String> options, int state, bool ascending)
        sort,
  }) {
    return check(name, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
  }) {
    return check?.call(name, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (check != null) {
      return check(name, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterHeader value) header,
    required TResult Function(FilterSeparator value) separator,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSort value) sort,
  }) {
    return check(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
  }) {
    return check?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) {
    if (check != null) {
      return check(this);
    }
    return orElse();
  }
}

abstract class FilterCheck implements Filter {
  const factory FilterCheck(String name, {bool state}) = _$FilterCheck;

  @override
  String get name;
  bool get state;
  @override
  @JsonKey(ignore: true)
  $FilterCheckCopyWith<FilterCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterSortCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterSortCopyWith(
          FilterSort value, $Res Function(FilterSort) then) =
      _$FilterSortCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<String> options, int state, bool ascending});
}

/// @nodoc
class _$FilterSortCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $FilterSortCopyWith<$Res> {
  _$FilterSortCopyWithImpl(FilterSort _value, $Res Function(FilterSort) _then)
      : super(_value, (v) => _then(v as FilterSort));

  @override
  FilterSort get _value => super._value as FilterSort;

  @override
  $Res call({
    Object? name = freezed,
    Object? options = freezed,
    Object? state = freezed,
    Object? ascending = freezed,
  }) {
    return _then(FilterSort(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      options == freezed
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int,
      ascending == freezed
          ? _value.ascending
          : ascending // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FilterSort with DiagnosticableTreeMixin implements FilterSort {
  const _$FilterSort(this.name, this.options, this.state, this.ascending);

  @override
  final String name;
  @override
  final List<String> options;
  @override
  final int state;
  @override
  final bool ascending;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.sort(name: $name, options: $options, state: $state, ascending: $ascending)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.sort'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('ascending', ascending));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterSort &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.options, options) &&
            const DeepCollectionEquality().equals(other.state, state) &&
            const DeepCollectionEquality().equals(other.ascending, ascending));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(options),
      const DeepCollectionEquality().hash(state),
      const DeepCollectionEquality().hash(ascending));

  @JsonKey(ignore: true)
  @override
  $FilterSortCopyWith<FilterSort> get copyWith =>
      _$FilterSortCopyWithImpl<FilterSort>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) header,
    required TResult Function(String name) separator,
    required TResult Function(String name, List<String> options, int state)
        select,
    required TResult Function(String name, String state) text,
    required TResult Function(String name, bool state) check,
    required TResult Function(
            String name, List<String> options, int state, bool ascending)
        sort,
  }) {
    return sort(name, options, state, ascending);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
  }) {
    return sort?.call(name, options, state, ascending);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? header,
    TResult Function(String name)? separator,
    TResult Function(String name, List<String> options, int state)? select,
    TResult Function(String name, String state)? text,
    TResult Function(String name, bool state)? check,
    TResult Function(
            String name, List<String> options, int state, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (sort != null) {
      return sort(name, options, state, ascending);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterHeader value) header,
    required TResult Function(FilterSeparator value) separator,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSort value) sort,
  }) {
    return sort(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
  }) {
    return sort?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterHeader value)? header,
    TResult Function(FilterSeparator value)? separator,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) {
    if (sort != null) {
      return sort(this);
    }
    return orElse();
  }
}

abstract class FilterSort implements Filter {
  const factory FilterSort(
          String name, List<String> options, int state, bool ascending) =
      _$FilterSort;

  @override
  String get name;
  List<String> get options;
  int get state;
  bool get ascending;
  @override
  @JsonKey(ignore: true)
  $FilterSortCopyWith<FilterSort> get copyWith =>
      throw _privateConstructorUsedError;
}
