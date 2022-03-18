// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chapter_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChapterInfoTearOff {
  const _$ChapterInfoTearOff();

  _ChapterInfo call(String key, String name,
      {int dateUpload = 0, double number = -1, String scanlator = ''}) {
    return _ChapterInfo(
      key,
      name,
      dateUpload: dateUpload,
      number: number,
      scanlator: scanlator,
    );
  }
}

/// @nodoc
const $ChapterInfo = _$ChapterInfoTearOff();

/// @nodoc
mixin _$ChapterInfo {
  String get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get dateUpload => throw _privateConstructorUsedError;
  double get number => throw _privateConstructorUsedError;
  String get scanlator => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChapterInfoCopyWith<ChapterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterInfoCopyWith<$Res> {
  factory $ChapterInfoCopyWith(
          ChapterInfo value, $Res Function(ChapterInfo) then) =
      _$ChapterInfoCopyWithImpl<$Res>;
  $Res call(
      {String key,
      String name,
      int dateUpload,
      double number,
      String scanlator});
}

/// @nodoc
class _$ChapterInfoCopyWithImpl<$Res> implements $ChapterInfoCopyWith<$Res> {
  _$ChapterInfoCopyWithImpl(this._value, this._then);

  final ChapterInfo _value;
  // ignore: unused_field
  final $Res Function(ChapterInfo) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? name = freezed,
    Object? dateUpload = freezed,
    Object? number = freezed,
    Object? scanlator = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateUpload: dateUpload == freezed
          ? _value.dateUpload
          : dateUpload // ignore: cast_nullable_to_non_nullable
              as int,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double,
      scanlator: scanlator == freezed
          ? _value.scanlator
          : scanlator // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ChapterInfoCopyWith<$Res>
    implements $ChapterInfoCopyWith<$Res> {
  factory _$ChapterInfoCopyWith(
          _ChapterInfo value, $Res Function(_ChapterInfo) then) =
      __$ChapterInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String key,
      String name,
      int dateUpload,
      double number,
      String scanlator});
}

/// @nodoc
class __$ChapterInfoCopyWithImpl<$Res> extends _$ChapterInfoCopyWithImpl<$Res>
    implements _$ChapterInfoCopyWith<$Res> {
  __$ChapterInfoCopyWithImpl(
      _ChapterInfo _value, $Res Function(_ChapterInfo) _then)
      : super(_value, (v) => _then(v as _ChapterInfo));

  @override
  _ChapterInfo get _value => super._value as _ChapterInfo;

  @override
  $Res call({
    Object? key = freezed,
    Object? name = freezed,
    Object? dateUpload = freezed,
    Object? number = freezed,
    Object? scanlator = freezed,
  }) {
    return _then(_ChapterInfo(
      key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateUpload: dateUpload == freezed
          ? _value.dateUpload
          : dateUpload // ignore: cast_nullable_to_non_nullable
              as int,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double,
      scanlator: scanlator == freezed
          ? _value.scanlator
          : scanlator // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ChapterInfo with DiagnosticableTreeMixin implements _ChapterInfo {
  _$_ChapterInfo(this.key, this.name,
      {this.dateUpload = 0, this.number = -1, this.scanlator = ''});

  @override
  final String key;
  @override
  final String name;
  @JsonKey()
  @override
  final int dateUpload;
  @JsonKey()
  @override
  final double number;
  @JsonKey()
  @override
  final String scanlator;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterInfo(key: $key, name: $name, dateUpload: $dateUpload, number: $number, scanlator: $scanlator)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterInfo'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('dateUpload', dateUpload))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('scanlator', scanlator));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChapterInfo &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.dateUpload, dateUpload) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality().equals(other.scanlator, scanlator));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(dateUpload),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(scanlator));

  @JsonKey(ignore: true)
  @override
  _$ChapterInfoCopyWith<_ChapterInfo> get copyWith =>
      __$ChapterInfoCopyWithImpl<_ChapterInfo>(this, _$identity);
}

abstract class _ChapterInfo implements ChapterInfo {
  factory _ChapterInfo(String key, String name,
      {int dateUpload, double number, String scanlator}) = _$_ChapterInfo;

  @override
  String get key;
  @override
  String get name;
  @override
  int get dateUpload;
  @override
  double get number;
  @override
  String get scanlator;
  @override
  @JsonKey(ignore: true)
  _$ChapterInfoCopyWith<_ChapterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
