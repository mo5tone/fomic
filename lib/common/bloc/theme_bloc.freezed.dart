// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'theme_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ThemeEventTearOff {
  const _$ThemeEventTearOff();

  ThemeEventPrimarySwatch primarySwatch(MaterialColor primarySwatch) {
    return ThemeEventPrimarySwatch(
      primarySwatch,
    );
  }

  ThemeEventBrightness brightness([Brightness? brightness]) {
    return ThemeEventBrightness(
      brightness,
    );
  }
}

/// @nodoc
const $ThemeEvent = _$ThemeEventTearOff();

/// @nodoc
mixin _$ThemeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MaterialColor primarySwatch) primarySwatch,
    required TResult Function(Brightness? brightness) brightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MaterialColor primarySwatch)? primarySwatch,
    TResult Function(Brightness? brightness)? brightness,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeEventPrimarySwatch value) primarySwatch,
    required TResult Function(ThemeEventBrightness value) brightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeEventPrimarySwatch value)? primarySwatch,
    TResult Function(ThemeEventBrightness value)? brightness,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeEventCopyWith<$Res> {
  factory $ThemeEventCopyWith(
          ThemeEvent value, $Res Function(ThemeEvent) then) =
      _$ThemeEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ThemeEventCopyWithImpl<$Res> implements $ThemeEventCopyWith<$Res> {
  _$ThemeEventCopyWithImpl(this._value, this._then);

  final ThemeEvent _value;
  // ignore: unused_field
  final $Res Function(ThemeEvent) _then;
}

/// @nodoc
abstract class $ThemeEventPrimarySwatchCopyWith<$Res> {
  factory $ThemeEventPrimarySwatchCopyWith(ThemeEventPrimarySwatch value,
          $Res Function(ThemeEventPrimarySwatch) then) =
      _$ThemeEventPrimarySwatchCopyWithImpl<$Res>;
  $Res call({MaterialColor primarySwatch});
}

/// @nodoc
class _$ThemeEventPrimarySwatchCopyWithImpl<$Res>
    extends _$ThemeEventCopyWithImpl<$Res>
    implements $ThemeEventPrimarySwatchCopyWith<$Res> {
  _$ThemeEventPrimarySwatchCopyWithImpl(ThemeEventPrimarySwatch _value,
      $Res Function(ThemeEventPrimarySwatch) _then)
      : super(_value, (v) => _then(v as ThemeEventPrimarySwatch));

  @override
  ThemeEventPrimarySwatch get _value => super._value as ThemeEventPrimarySwatch;

  @override
  $Res call({
    Object? primarySwatch = freezed,
  }) {
    return _then(ThemeEventPrimarySwatch(
      primarySwatch == freezed
          ? _value.primarySwatch
          : primarySwatch // ignore: cast_nullable_to_non_nullable
              as MaterialColor,
    ));
  }
}

/// @nodoc

class _$ThemeEventPrimarySwatch
    with DiagnosticableTreeMixin
    implements ThemeEventPrimarySwatch {
  const _$ThemeEventPrimarySwatch(this.primarySwatch);

  @override
  final MaterialColor primarySwatch;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ThemeEvent.primarySwatch(primarySwatch: $primarySwatch)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ThemeEvent.primarySwatch'))
      ..add(DiagnosticsProperty('primarySwatch', primarySwatch));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ThemeEventPrimarySwatch &&
            (identical(other.primarySwatch, primarySwatch) ||
                const DeepCollectionEquality()
                    .equals(other.primarySwatch, primarySwatch)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(primarySwatch);

  @JsonKey(ignore: true)
  @override
  $ThemeEventPrimarySwatchCopyWith<ThemeEventPrimarySwatch> get copyWith =>
      _$ThemeEventPrimarySwatchCopyWithImpl<ThemeEventPrimarySwatch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MaterialColor primarySwatch) primarySwatch,
    required TResult Function(Brightness? brightness) brightness,
  }) {
    return primarySwatch(this.primarySwatch);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MaterialColor primarySwatch)? primarySwatch,
    TResult Function(Brightness? brightness)? brightness,
    required TResult orElse(),
  }) {
    if (primarySwatch != null) {
      return primarySwatch(this.primarySwatch);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeEventPrimarySwatch value) primarySwatch,
    required TResult Function(ThemeEventBrightness value) brightness,
  }) {
    return primarySwatch(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeEventPrimarySwatch value)? primarySwatch,
    TResult Function(ThemeEventBrightness value)? brightness,
    required TResult orElse(),
  }) {
    if (primarySwatch != null) {
      return primarySwatch(this);
    }
    return orElse();
  }
}

abstract class ThemeEventPrimarySwatch implements ThemeEvent {
  const factory ThemeEventPrimarySwatch(MaterialColor primarySwatch) =
      _$ThemeEventPrimarySwatch;

  MaterialColor get primarySwatch => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThemeEventPrimarySwatchCopyWith<ThemeEventPrimarySwatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeEventBrightnessCopyWith<$Res> {
  factory $ThemeEventBrightnessCopyWith(ThemeEventBrightness value,
          $Res Function(ThemeEventBrightness) then) =
      _$ThemeEventBrightnessCopyWithImpl<$Res>;
  $Res call({Brightness? brightness});
}

/// @nodoc
class _$ThemeEventBrightnessCopyWithImpl<$Res>
    extends _$ThemeEventCopyWithImpl<$Res>
    implements $ThemeEventBrightnessCopyWith<$Res> {
  _$ThemeEventBrightnessCopyWithImpl(
      ThemeEventBrightness _value, $Res Function(ThemeEventBrightness) _then)
      : super(_value, (v) => _then(v as ThemeEventBrightness));

  @override
  ThemeEventBrightness get _value => super._value as ThemeEventBrightness;

  @override
  $Res call({
    Object? brightness = freezed,
  }) {
    return _then(ThemeEventBrightness(
      brightness == freezed
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness?,
    ));
  }
}

/// @nodoc

class _$ThemeEventBrightness
    with DiagnosticableTreeMixin
    implements ThemeEventBrightness {
  const _$ThemeEventBrightness([this.brightness]);

  @override
  final Brightness? brightness;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ThemeEvent.brightness(brightness: $brightness)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ThemeEvent.brightness'))
      ..add(DiagnosticsProperty('brightness', brightness));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ThemeEventBrightness &&
            (identical(other.brightness, brightness) ||
                const DeepCollectionEquality()
                    .equals(other.brightness, brightness)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(brightness);

  @JsonKey(ignore: true)
  @override
  $ThemeEventBrightnessCopyWith<ThemeEventBrightness> get copyWith =>
      _$ThemeEventBrightnessCopyWithImpl<ThemeEventBrightness>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MaterialColor primarySwatch) primarySwatch,
    required TResult Function(Brightness? brightness) brightness,
  }) {
    return brightness(this.brightness);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MaterialColor primarySwatch)? primarySwatch,
    TResult Function(Brightness? brightness)? brightness,
    required TResult orElse(),
  }) {
    if (brightness != null) {
      return brightness(this.brightness);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeEventPrimarySwatch value) primarySwatch,
    required TResult Function(ThemeEventBrightness value) brightness,
  }) {
    return brightness(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeEventPrimarySwatch value)? primarySwatch,
    TResult Function(ThemeEventBrightness value)? brightness,
    required TResult orElse(),
  }) {
    if (brightness != null) {
      return brightness(this);
    }
    return orElse();
  }
}

abstract class ThemeEventBrightness implements ThemeEvent {
  const factory ThemeEventBrightness([Brightness? brightness]) =
      _$ThemeEventBrightness;

  Brightness? get brightness => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThemeEventBrightnessCopyWith<ThemeEventBrightness> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ThemeStateTearOff {
  const _$ThemeStateTearOff();

  _ThemeState call(MaterialColor primarySwatch, [Brightness? brightness]) {
    return _ThemeState(
      primarySwatch,
      brightness,
    );
  }
}

/// @nodoc
const $ThemeState = _$ThemeStateTearOff();

/// @nodoc
mixin _$ThemeState {
  MaterialColor get primarySwatch => throw _privateConstructorUsedError;
  Brightness? get brightness => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeStateCopyWith<ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
          ThemeState value, $Res Function(ThemeState) then) =
      _$ThemeStateCopyWithImpl<$Res>;
  $Res call({MaterialColor primarySwatch, Brightness? brightness});
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res> implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

  final ThemeState _value;
  // ignore: unused_field
  final $Res Function(ThemeState) _then;

  @override
  $Res call({
    Object? primarySwatch = freezed,
    Object? brightness = freezed,
  }) {
    return _then(_value.copyWith(
      primarySwatch: primarySwatch == freezed
          ? _value.primarySwatch
          : primarySwatch // ignore: cast_nullable_to_non_nullable
              as MaterialColor,
      brightness: brightness == freezed
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness?,
    ));
  }
}

/// @nodoc
abstract class _$ThemeStateCopyWith<$Res> implements $ThemeStateCopyWith<$Res> {
  factory _$ThemeStateCopyWith(
          _ThemeState value, $Res Function(_ThemeState) then) =
      __$ThemeStateCopyWithImpl<$Res>;
  @override
  $Res call({MaterialColor primarySwatch, Brightness? brightness});
}

/// @nodoc
class __$ThemeStateCopyWithImpl<$Res> extends _$ThemeStateCopyWithImpl<$Res>
    implements _$ThemeStateCopyWith<$Res> {
  __$ThemeStateCopyWithImpl(
      _ThemeState _value, $Res Function(_ThemeState) _then)
      : super(_value, (v) => _then(v as _ThemeState));

  @override
  _ThemeState get _value => super._value as _ThemeState;

  @override
  $Res call({
    Object? primarySwatch = freezed,
    Object? brightness = freezed,
  }) {
    return _then(_ThemeState(
      primarySwatch == freezed
          ? _value.primarySwatch
          : primarySwatch // ignore: cast_nullable_to_non_nullable
              as MaterialColor,
      brightness == freezed
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness?,
    ));
  }
}

/// @nodoc

class _$_ThemeState extends _ThemeState with DiagnosticableTreeMixin {
  const _$_ThemeState(this.primarySwatch, [this.brightness]) : super._();

  @override
  final MaterialColor primarySwatch;
  @override
  final Brightness? brightness;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ThemeState(primarySwatch: $primarySwatch, brightness: $brightness)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ThemeState'))
      ..add(DiagnosticsProperty('primarySwatch', primarySwatch))
      ..add(DiagnosticsProperty('brightness', brightness));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ThemeState &&
            (identical(other.primarySwatch, primarySwatch) ||
                const DeepCollectionEquality()
                    .equals(other.primarySwatch, primarySwatch)) &&
            (identical(other.brightness, brightness) ||
                const DeepCollectionEquality()
                    .equals(other.brightness, brightness)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(primarySwatch) ^
      const DeepCollectionEquality().hash(brightness);

  @JsonKey(ignore: true)
  @override
  _$ThemeStateCopyWith<_ThemeState> get copyWith =>
      __$ThemeStateCopyWithImpl<_ThemeState>(this, _$identity);
}

abstract class _ThemeState extends ThemeState {
  const factory _ThemeState(MaterialColor primarySwatch,
      [Brightness? brightness]) = _$_ThemeState;
  const _ThemeState._() : super._();

  @override
  MaterialColor get primarySwatch => throw _privateConstructorUsedError;
  @override
  Brightness? get brightness => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ThemeStateCopyWith<_ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}
