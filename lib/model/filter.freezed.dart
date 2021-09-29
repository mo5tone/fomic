// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

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

  FilterNote note(String name) {
    return FilterNote(
      name,
    );
  }

  FilterText text(String name, {String value = ''}) {
    return FilterText(
      name,
      value: value,
    );
  }

  FilterCheck check(String name,
      {bool allowsExclusion = false, bool value = false}) {
    return FilterCheck(
      name,
      allowsExclusion: allowsExclusion,
      value: value,
    );
  }

  FilterSelect select(String name, List<MapEntry<String, dynamic>> options,
      {int value = 0}) {
    return FilterSelect(
      name,
      options,
      value: value,
    );
  }

  FilterGroup group(String name, List<Filter> filterList) {
    return FilterGroup(
      name,
      filterList,
    );
  }

  FilterSort sort(String name, List<MapEntry<String, dynamic>> options,
      int value, bool ascending) {
    return FilterSort(
      name,
      options,
      value,
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
    required TResult Function(String name) note,
    required TResult Function(String name, String value) text,
    required TResult Function(String name, bool allowsExclusion, bool value)
        check,
    required TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)
        select,
    required TResult Function(String name, List<Filter> filterList) group,
    required TResult Function(String name,
            List<MapEntry<String, dynamic>> options, int value, bool ascending)
        sort,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? note,
    TResult Function(String name, String value)? text,
    TResult Function(String name, bool allowsExclusion, bool value)? check,
    TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)?
        select,
    TResult Function(String name, List<Filter> filterList)? group,
    TResult Function(String name, List<MapEntry<String, dynamic>> options,
            int value, bool ascending)?
        sort,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterNote value) note,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterGroup value) group,
    required TResult Function(FilterSort value) sort,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterNote value)? note,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterGroup value)? group,
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
abstract class $FilterNoteCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterNoteCopyWith(
          FilterNote value, $Res Function(FilterNote) then) =
      _$FilterNoteCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class _$FilterNoteCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $FilterNoteCopyWith<$Res> {
  _$FilterNoteCopyWithImpl(FilterNote _value, $Res Function(FilterNote) _then)
      : super(_value, (v) => _then(v as FilterNote));

  @override
  FilterNote get _value => super._value as FilterNote;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(FilterNote(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterNote with DiagnosticableTreeMixin implements FilterNote {
  const _$FilterNote(this.name);

  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.note(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.note'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilterNote &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  $FilterNoteCopyWith<FilterNote> get copyWith =>
      _$FilterNoteCopyWithImpl<FilterNote>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) note,
    required TResult Function(String name, String value) text,
    required TResult Function(String name, bool allowsExclusion, bool value)
        check,
    required TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)
        select,
    required TResult Function(String name, List<Filter> filterList) group,
    required TResult Function(String name,
            List<MapEntry<String, dynamic>> options, int value, bool ascending)
        sort,
  }) {
    return note(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? note,
    TResult Function(String name, String value)? text,
    TResult Function(String name, bool allowsExclusion, bool value)? check,
    TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)?
        select,
    TResult Function(String name, List<Filter> filterList)? group,
    TResult Function(String name, List<MapEntry<String, dynamic>> options,
            int value, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (note != null) {
      return note(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterNote value) note,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterGroup value) group,
    required TResult Function(FilterSort value) sort,
  }) {
    return note(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterNote value)? note,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterGroup value)? group,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) {
    if (note != null) {
      return note(this);
    }
    return orElse();
  }
}

abstract class FilterNote implements Filter {
  const factory FilterNote(String name) = _$FilterNote;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $FilterNoteCopyWith<FilterNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterTextCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterTextCopyWith(
          FilterText value, $Res Function(FilterText) then) =
      _$FilterTextCopyWithImpl<$Res>;
  @override
  $Res call({String name, String value});
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
    Object? value = freezed,
  }) {
    return _then(FilterText(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterText with DiagnosticableTreeMixin implements FilterText {
  const _$FilterText(this.name, {this.value = ''});

  @override
  final String name;
  @JsonKey(defaultValue: '')
  @override
  final String value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.text(name: $name, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.text'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilterText &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $FilterTextCopyWith<FilterText> get copyWith =>
      _$FilterTextCopyWithImpl<FilterText>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) note,
    required TResult Function(String name, String value) text,
    required TResult Function(String name, bool allowsExclusion, bool value)
        check,
    required TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)
        select,
    required TResult Function(String name, List<Filter> filterList) group,
    required TResult Function(String name,
            List<MapEntry<String, dynamic>> options, int value, bool ascending)
        sort,
  }) {
    return text(name, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? note,
    TResult Function(String name, String value)? text,
    TResult Function(String name, bool allowsExclusion, bool value)? check,
    TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)?
        select,
    TResult Function(String name, List<Filter> filterList)? group,
    TResult Function(String name, List<MapEntry<String, dynamic>> options,
            int value, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(name, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterNote value) note,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterGroup value) group,
    required TResult Function(FilterSort value) sort,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterNote value)? note,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterGroup value)? group,
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
  const factory FilterText(String name, {String value}) = _$FilterText;

  @override
  String get name => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
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
  $Res call({String name, bool allowsExclusion, bool value});
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
    Object? allowsExclusion = freezed,
    Object? value = freezed,
  }) {
    return _then(FilterCheck(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      allowsExclusion: allowsExclusion == freezed
          ? _value.allowsExclusion
          : allowsExclusion // ignore: cast_nullable_to_non_nullable
              as bool,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FilterCheck with DiagnosticableTreeMixin implements FilterCheck {
  const _$FilterCheck(this.name,
      {this.allowsExclusion = false, this.value = false});

  @override
  final String name;
  @JsonKey(defaultValue: false)
  @override
  final bool allowsExclusion;
  @JsonKey(defaultValue: false)
  @override
  final bool value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.check(name: $name, allowsExclusion: $allowsExclusion, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.check'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('allowsExclusion', allowsExclusion))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilterCheck &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.allowsExclusion, allowsExclusion) ||
                const DeepCollectionEquality()
                    .equals(other.allowsExclusion, allowsExclusion)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(allowsExclusion) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $FilterCheckCopyWith<FilterCheck> get copyWith =>
      _$FilterCheckCopyWithImpl<FilterCheck>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) note,
    required TResult Function(String name, String value) text,
    required TResult Function(String name, bool allowsExclusion, bool value)
        check,
    required TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)
        select,
    required TResult Function(String name, List<Filter> filterList) group,
    required TResult Function(String name,
            List<MapEntry<String, dynamic>> options, int value, bool ascending)
        sort,
  }) {
    return check(name, allowsExclusion, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? note,
    TResult Function(String name, String value)? text,
    TResult Function(String name, bool allowsExclusion, bool value)? check,
    TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)?
        select,
    TResult Function(String name, List<Filter> filterList)? group,
    TResult Function(String name, List<MapEntry<String, dynamic>> options,
            int value, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (check != null) {
      return check(name, allowsExclusion, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterNote value) note,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterGroup value) group,
    required TResult Function(FilterSort value) sort,
  }) {
    return check(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterNote value)? note,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterGroup value)? group,
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
  const factory FilterCheck(String name, {bool allowsExclusion, bool value}) =
      _$FilterCheck;

  @override
  String get name => throw _privateConstructorUsedError;
  bool get allowsExclusion => throw _privateConstructorUsedError;
  bool get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $FilterCheckCopyWith<FilterCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterSelectCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterSelectCopyWith(
          FilterSelect value, $Res Function(FilterSelect) then) =
      _$FilterSelectCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<MapEntry<String, dynamic>> options, int value});
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
    Object? value = freezed,
  }) {
    return _then(FilterSelect(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      options == freezed
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<MapEntry<String, dynamic>>,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FilterSelect with DiagnosticableTreeMixin implements FilterSelect {
  const _$FilterSelect(this.name, this.options, {this.value = 0});

  @override
  final String name;
  @override
  final List<MapEntry<String, dynamic>> options;
  @JsonKey(defaultValue: 0)
  @override
  final int value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.select(name: $name, options: $options, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.select'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilterSelect &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality()
                    .equals(other.options, options)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(options) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $FilterSelectCopyWith<FilterSelect> get copyWith =>
      _$FilterSelectCopyWithImpl<FilterSelect>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) note,
    required TResult Function(String name, String value) text,
    required TResult Function(String name, bool allowsExclusion, bool value)
        check,
    required TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)
        select,
    required TResult Function(String name, List<Filter> filterList) group,
    required TResult Function(String name,
            List<MapEntry<String, dynamic>> options, int value, bool ascending)
        sort,
  }) {
    return select(name, options, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? note,
    TResult Function(String name, String value)? text,
    TResult Function(String name, bool allowsExclusion, bool value)? check,
    TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)?
        select,
    TResult Function(String name, List<Filter> filterList)? group,
    TResult Function(String name, List<MapEntry<String, dynamic>> options,
            int value, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(name, options, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterNote value) note,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterGroup value) group,
    required TResult Function(FilterSort value) sort,
  }) {
    return select(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterNote value)? note,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterGroup value)? group,
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
  const factory FilterSelect(
          String name, List<MapEntry<String, dynamic>> options, {int value}) =
      _$FilterSelect;

  @override
  String get name => throw _privateConstructorUsedError;
  List<MapEntry<String, dynamic>> get options =>
      throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $FilterSelectCopyWith<FilterSelect> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterGroupCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterGroupCopyWith(
          FilterGroup value, $Res Function(FilterGroup) then) =
      _$FilterGroupCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<Filter> filterList});
}

/// @nodoc
class _$FilterGroupCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $FilterGroupCopyWith<$Res> {
  _$FilterGroupCopyWithImpl(
      FilterGroup _value, $Res Function(FilterGroup) _then)
      : super(_value, (v) => _then(v as FilterGroup));

  @override
  FilterGroup get _value => super._value as FilterGroup;

  @override
  $Res call({
    Object? name = freezed,
    Object? filterList = freezed,
  }) {
    return _then(FilterGroup(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      filterList == freezed
          ? _value.filterList
          : filterList // ignore: cast_nullable_to_non_nullable
              as List<Filter>,
    ));
  }
}

/// @nodoc

class _$FilterGroup with DiagnosticableTreeMixin implements FilterGroup {
  const _$FilterGroup(this.name, this.filterList);

  @override
  final String name;
  @override
  final List<Filter> filterList;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.group(name: $name, filterList: $filterList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.group'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('filterList', filterList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilterGroup &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.filterList, filterList) ||
                const DeepCollectionEquality()
                    .equals(other.filterList, filterList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(filterList);

  @JsonKey(ignore: true)
  @override
  $FilterGroupCopyWith<FilterGroup> get copyWith =>
      _$FilterGroupCopyWithImpl<FilterGroup>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) note,
    required TResult Function(String name, String value) text,
    required TResult Function(String name, bool allowsExclusion, bool value)
        check,
    required TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)
        select,
    required TResult Function(String name, List<Filter> filterList) group,
    required TResult Function(String name,
            List<MapEntry<String, dynamic>> options, int value, bool ascending)
        sort,
  }) {
    return group(name, filterList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? note,
    TResult Function(String name, String value)? text,
    TResult Function(String name, bool allowsExclusion, bool value)? check,
    TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)?
        select,
    TResult Function(String name, List<Filter> filterList)? group,
    TResult Function(String name, List<MapEntry<String, dynamic>> options,
            int value, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (group != null) {
      return group(name, filterList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterNote value) note,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterGroup value) group,
    required TResult Function(FilterSort value) sort,
  }) {
    return group(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterNote value)? note,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterGroup value)? group,
    TResult Function(FilterSort value)? sort,
    required TResult orElse(),
  }) {
    if (group != null) {
      return group(this);
    }
    return orElse();
  }
}

abstract class FilterGroup implements Filter {
  const factory FilterGroup(String name, List<Filter> filterList) =
      _$FilterGroup;

  @override
  String get name => throw _privateConstructorUsedError;
  List<Filter> get filterList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $FilterGroupCopyWith<FilterGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterSortCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $FilterSortCopyWith(
          FilterSort value, $Res Function(FilterSort) then) =
      _$FilterSortCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      List<MapEntry<String, dynamic>> options,
      int value,
      bool ascending});
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
    Object? value = freezed,
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
              as List<MapEntry<String, dynamic>>,
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
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
  const _$FilterSort(this.name, this.options, this.value, this.ascending);

  @override
  final String name;
  @override
  final List<MapEntry<String, dynamic>> options;
  @override
  final int value;
  @override
  final bool ascending;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter.sort(name: $name, options: $options, value: $value, ascending: $ascending)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter.sort'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('ascending', ascending));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilterSort &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality()
                    .equals(other.options, options)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.ascending, ascending) ||
                const DeepCollectionEquality()
                    .equals(other.ascending, ascending)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(options) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(ascending);

  @JsonKey(ignore: true)
  @override
  $FilterSortCopyWith<FilterSort> get copyWith =>
      _$FilterSortCopyWithImpl<FilterSort>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) note,
    required TResult Function(String name, String value) text,
    required TResult Function(String name, bool allowsExclusion, bool value)
        check,
    required TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)
        select,
    required TResult Function(String name, List<Filter> filterList) group,
    required TResult Function(String name,
            List<MapEntry<String, dynamic>> options, int value, bool ascending)
        sort,
  }) {
    return sort(name, options, value, ascending);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? note,
    TResult Function(String name, String value)? text,
    TResult Function(String name, bool allowsExclusion, bool value)? check,
    TResult Function(
            String name, List<MapEntry<String, dynamic>> options, int value)?
        select,
    TResult Function(String name, List<Filter> filterList)? group,
    TResult Function(String name, List<MapEntry<String, dynamic>> options,
            int value, bool ascending)?
        sort,
    required TResult orElse(),
  }) {
    if (sort != null) {
      return sort(name, options, value, ascending);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterNote value) note,
    required TResult Function(FilterText value) text,
    required TResult Function(FilterCheck value) check,
    required TResult Function(FilterSelect value) select,
    required TResult Function(FilterGroup value) group,
    required TResult Function(FilterSort value) sort,
  }) {
    return sort(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterNote value)? note,
    TResult Function(FilterText value)? text,
    TResult Function(FilterCheck value)? check,
    TResult Function(FilterSelect value)? select,
    TResult Function(FilterGroup value)? group,
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
  const factory FilterSort(String name, List<MapEntry<String, dynamic>> options,
      int value, bool ascending) = _$FilterSort;

  @override
  String get name => throw _privateConstructorUsedError;
  List<MapEntry<String, dynamic>> get options =>
      throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  bool get ascending => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $FilterSortCopyWith<FilterSort> get copyWith =>
      throw _privateConstructorUsedError;
}
