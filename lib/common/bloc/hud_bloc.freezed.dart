// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hud_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HUDEventTearOff {
  const _$HUDEventTearOff();

  HUDEventToast toast(String message, {Duration? duration}) {
    return HUDEventToast(
      message,
      duration: duration,
    );
  }

  HUDEventShow show() {
    return const HUDEventShow();
  }

  HUDEventDismiss dismiss() {
    return const HUDEventDismiss();
  }
}

/// @nodoc
const $HUDEvent = _$HUDEventTearOff();

/// @nodoc
mixin _$HUDEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Duration? duration) toast,
    required TResult Function() show,
    required TResult Function() dismiss,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? show,
    TResult Function()? dismiss,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? show,
    TResult Function()? dismiss,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HUDEventToast value) toast,
    required TResult Function(HUDEventShow value) show,
    required TResult Function(HUDEventDismiss value) dismiss,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HUDEventToast value)? toast,
    TResult Function(HUDEventShow value)? show,
    TResult Function(HUDEventDismiss value)? dismiss,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HUDEventToast value)? toast,
    TResult Function(HUDEventShow value)? show,
    TResult Function(HUDEventDismiss value)? dismiss,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HUDEventCopyWith<$Res> {
  factory $HUDEventCopyWith(HUDEvent value, $Res Function(HUDEvent) then) =
      _$HUDEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$HUDEventCopyWithImpl<$Res> implements $HUDEventCopyWith<$Res> {
  _$HUDEventCopyWithImpl(this._value, this._then);

  final HUDEvent _value;
  // ignore: unused_field
  final $Res Function(HUDEvent) _then;
}

/// @nodoc
abstract class $HUDEventToastCopyWith<$Res> {
  factory $HUDEventToastCopyWith(
          HUDEventToast value, $Res Function(HUDEventToast) then) =
      _$HUDEventToastCopyWithImpl<$Res>;
  $Res call({String message, Duration? duration});
}

/// @nodoc
class _$HUDEventToastCopyWithImpl<$Res> extends _$HUDEventCopyWithImpl<$Res>
    implements $HUDEventToastCopyWith<$Res> {
  _$HUDEventToastCopyWithImpl(
      HUDEventToast _value, $Res Function(HUDEventToast) _then)
      : super(_value, (v) => _then(v as HUDEventToast));

  @override
  HUDEventToast get _value => super._value as HUDEventToast;

  @override
  $Res call({
    Object? message = freezed,
    Object? duration = freezed,
  }) {
    return _then(HUDEventToast(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$HUDEventToast with DiagnosticableTreeMixin implements HUDEventToast {
  const _$HUDEventToast(this.message, {this.duration});

  @override
  final String message;
  @override
  final Duration? duration;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HUDEvent.toast(message: $message, duration: $duration)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HUDEvent.toast'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('duration', duration));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HUDEventToast &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  $HUDEventToastCopyWith<HUDEventToast> get copyWith =>
      _$HUDEventToastCopyWithImpl<HUDEventToast>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Duration? duration) toast,
    required TResult Function() show,
    required TResult Function() dismiss,
  }) {
    return toast(message, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? show,
    TResult Function()? dismiss,
  }) {
    return toast?.call(message, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? show,
    TResult Function()? dismiss,
    required TResult orElse(),
  }) {
    if (toast != null) {
      return toast(message, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HUDEventToast value) toast,
    required TResult Function(HUDEventShow value) show,
    required TResult Function(HUDEventDismiss value) dismiss,
  }) {
    return toast(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HUDEventToast value)? toast,
    TResult Function(HUDEventShow value)? show,
    TResult Function(HUDEventDismiss value)? dismiss,
  }) {
    return toast?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HUDEventToast value)? toast,
    TResult Function(HUDEventShow value)? show,
    TResult Function(HUDEventDismiss value)? dismiss,
    required TResult orElse(),
  }) {
    if (toast != null) {
      return toast(this);
    }
    return orElse();
  }
}

abstract class HUDEventToast implements HUDEvent {
  const factory HUDEventToast(String message, {Duration? duration}) =
      _$HUDEventToast;

  String get message;
  Duration? get duration;
  @JsonKey(ignore: true)
  $HUDEventToastCopyWith<HUDEventToast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HUDEventShowCopyWith<$Res> {
  factory $HUDEventShowCopyWith(
          HUDEventShow value, $Res Function(HUDEventShow) then) =
      _$HUDEventShowCopyWithImpl<$Res>;
}

/// @nodoc
class _$HUDEventShowCopyWithImpl<$Res> extends _$HUDEventCopyWithImpl<$Res>
    implements $HUDEventShowCopyWith<$Res> {
  _$HUDEventShowCopyWithImpl(
      HUDEventShow _value, $Res Function(HUDEventShow) _then)
      : super(_value, (v) => _then(v as HUDEventShow));

  @override
  HUDEventShow get _value => super._value as HUDEventShow;
}

/// @nodoc

class _$HUDEventShow with DiagnosticableTreeMixin implements HUDEventShow {
  const _$HUDEventShow();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HUDEvent.show()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HUDEvent.show'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HUDEventShow);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Duration? duration) toast,
    required TResult Function() show,
    required TResult Function() dismiss,
  }) {
    return show();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? show,
    TResult Function()? dismiss,
  }) {
    return show?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? show,
    TResult Function()? dismiss,
    required TResult orElse(),
  }) {
    if (show != null) {
      return show();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HUDEventToast value) toast,
    required TResult Function(HUDEventShow value) show,
    required TResult Function(HUDEventDismiss value) dismiss,
  }) {
    return show(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HUDEventToast value)? toast,
    TResult Function(HUDEventShow value)? show,
    TResult Function(HUDEventDismiss value)? dismiss,
  }) {
    return show?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HUDEventToast value)? toast,
    TResult Function(HUDEventShow value)? show,
    TResult Function(HUDEventDismiss value)? dismiss,
    required TResult orElse(),
  }) {
    if (show != null) {
      return show(this);
    }
    return orElse();
  }
}

abstract class HUDEventShow implements HUDEvent {
  const factory HUDEventShow() = _$HUDEventShow;
}

/// @nodoc
abstract class $HUDEventDismissCopyWith<$Res> {
  factory $HUDEventDismissCopyWith(
          HUDEventDismiss value, $Res Function(HUDEventDismiss) then) =
      _$HUDEventDismissCopyWithImpl<$Res>;
}

/// @nodoc
class _$HUDEventDismissCopyWithImpl<$Res> extends _$HUDEventCopyWithImpl<$Res>
    implements $HUDEventDismissCopyWith<$Res> {
  _$HUDEventDismissCopyWithImpl(
      HUDEventDismiss _value, $Res Function(HUDEventDismiss) _then)
      : super(_value, (v) => _then(v as HUDEventDismiss));

  @override
  HUDEventDismiss get _value => super._value as HUDEventDismiss;
}

/// @nodoc

class _$HUDEventDismiss
    with DiagnosticableTreeMixin
    implements HUDEventDismiss {
  const _$HUDEventDismiss();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HUDEvent.dismiss()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HUDEvent.dismiss'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HUDEventDismiss);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Duration? duration) toast,
    required TResult Function() show,
    required TResult Function() dismiss,
  }) {
    return dismiss();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? show,
    TResult Function()? dismiss,
  }) {
    return dismiss?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? show,
    TResult Function()? dismiss,
    required TResult orElse(),
  }) {
    if (dismiss != null) {
      return dismiss();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HUDEventToast value) toast,
    required TResult Function(HUDEventShow value) show,
    required TResult Function(HUDEventDismiss value) dismiss,
  }) {
    return dismiss(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HUDEventToast value)? toast,
    TResult Function(HUDEventShow value)? show,
    TResult Function(HUDEventDismiss value)? dismiss,
  }) {
    return dismiss?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HUDEventToast value)? toast,
    TResult Function(HUDEventShow value)? show,
    TResult Function(HUDEventDismiss value)? dismiss,
    required TResult orElse(),
  }) {
    if (dismiss != null) {
      return dismiss(this);
    }
    return orElse();
  }
}

abstract class HUDEventDismiss implements HUDEvent {
  const factory HUDEventDismiss() = _$HUDEventDismiss;
}

/// @nodoc
class _$HUDStateTearOff {
  const _$HUDStateTearOff();

  HUDStateToast toast(String message, {Duration? duration}) {
    return HUDStateToast(
      message,
      duration: duration,
    );
  }

  HUDStateLoading loading() {
    return const HUDStateLoading();
  }

  HUDStateDone done() {
    return const HUDStateDone();
  }
}

/// @nodoc
const $HUDState = _$HUDStateTearOff();

/// @nodoc
mixin _$HUDState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Duration? duration) toast,
    required TResult Function() loading,
    required TResult Function() done,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? loading,
    TResult Function()? done,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? loading,
    TResult Function()? done,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HUDStateToast value) toast,
    required TResult Function(HUDStateLoading value) loading,
    required TResult Function(HUDStateDone value) done,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HUDStateToast value)? toast,
    TResult Function(HUDStateLoading value)? loading,
    TResult Function(HUDStateDone value)? done,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HUDStateToast value)? toast,
    TResult Function(HUDStateLoading value)? loading,
    TResult Function(HUDStateDone value)? done,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HUDStateCopyWith<$Res> {
  factory $HUDStateCopyWith(HUDState value, $Res Function(HUDState) then) =
      _$HUDStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$HUDStateCopyWithImpl<$Res> implements $HUDStateCopyWith<$Res> {
  _$HUDStateCopyWithImpl(this._value, this._then);

  final HUDState _value;
  // ignore: unused_field
  final $Res Function(HUDState) _then;
}

/// @nodoc
abstract class $HUDStateToastCopyWith<$Res> {
  factory $HUDStateToastCopyWith(
          HUDStateToast value, $Res Function(HUDStateToast) then) =
      _$HUDStateToastCopyWithImpl<$Res>;
  $Res call({String message, Duration? duration});
}

/// @nodoc
class _$HUDStateToastCopyWithImpl<$Res> extends _$HUDStateCopyWithImpl<$Res>
    implements $HUDStateToastCopyWith<$Res> {
  _$HUDStateToastCopyWithImpl(
      HUDStateToast _value, $Res Function(HUDStateToast) _then)
      : super(_value, (v) => _then(v as HUDStateToast));

  @override
  HUDStateToast get _value => super._value as HUDStateToast;

  @override
  $Res call({
    Object? message = freezed,
    Object? duration = freezed,
  }) {
    return _then(HUDStateToast(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$HUDStateToast with DiagnosticableTreeMixin implements HUDStateToast {
  const _$HUDStateToast(this.message, {this.duration});

  @override
  final String message;
  @override
  final Duration? duration;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HUDState.toast(message: $message, duration: $duration)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HUDState.toast'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('duration', duration));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HUDStateToast &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  $HUDStateToastCopyWith<HUDStateToast> get copyWith =>
      _$HUDStateToastCopyWithImpl<HUDStateToast>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Duration? duration) toast,
    required TResult Function() loading,
    required TResult Function() done,
  }) {
    return toast(message, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? loading,
    TResult Function()? done,
  }) {
    return toast?.call(message, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? loading,
    TResult Function()? done,
    required TResult orElse(),
  }) {
    if (toast != null) {
      return toast(message, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HUDStateToast value) toast,
    required TResult Function(HUDStateLoading value) loading,
    required TResult Function(HUDStateDone value) done,
  }) {
    return toast(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HUDStateToast value)? toast,
    TResult Function(HUDStateLoading value)? loading,
    TResult Function(HUDStateDone value)? done,
  }) {
    return toast?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HUDStateToast value)? toast,
    TResult Function(HUDStateLoading value)? loading,
    TResult Function(HUDStateDone value)? done,
    required TResult orElse(),
  }) {
    if (toast != null) {
      return toast(this);
    }
    return orElse();
  }
}

abstract class HUDStateToast implements HUDState {
  const factory HUDStateToast(String message, {Duration? duration}) =
      _$HUDStateToast;

  String get message;
  Duration? get duration;
  @JsonKey(ignore: true)
  $HUDStateToastCopyWith<HUDStateToast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HUDStateLoadingCopyWith<$Res> {
  factory $HUDStateLoadingCopyWith(
          HUDStateLoading value, $Res Function(HUDStateLoading) then) =
      _$HUDStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$HUDStateLoadingCopyWithImpl<$Res> extends _$HUDStateCopyWithImpl<$Res>
    implements $HUDStateLoadingCopyWith<$Res> {
  _$HUDStateLoadingCopyWithImpl(
      HUDStateLoading _value, $Res Function(HUDStateLoading) _then)
      : super(_value, (v) => _then(v as HUDStateLoading));

  @override
  HUDStateLoading get _value => super._value as HUDStateLoading;
}

/// @nodoc

class _$HUDStateLoading
    with DiagnosticableTreeMixin
    implements HUDStateLoading {
  const _$HUDStateLoading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HUDState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HUDState.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HUDStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Duration? duration) toast,
    required TResult Function() loading,
    required TResult Function() done,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? loading,
    TResult Function()? done,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? loading,
    TResult Function()? done,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HUDStateToast value) toast,
    required TResult Function(HUDStateLoading value) loading,
    required TResult Function(HUDStateDone value) done,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HUDStateToast value)? toast,
    TResult Function(HUDStateLoading value)? loading,
    TResult Function(HUDStateDone value)? done,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HUDStateToast value)? toast,
    TResult Function(HUDStateLoading value)? loading,
    TResult Function(HUDStateDone value)? done,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HUDStateLoading implements HUDState {
  const factory HUDStateLoading() = _$HUDStateLoading;
}

/// @nodoc
abstract class $HUDStateDoneCopyWith<$Res> {
  factory $HUDStateDoneCopyWith(
          HUDStateDone value, $Res Function(HUDStateDone) then) =
      _$HUDStateDoneCopyWithImpl<$Res>;
}

/// @nodoc
class _$HUDStateDoneCopyWithImpl<$Res> extends _$HUDStateCopyWithImpl<$Res>
    implements $HUDStateDoneCopyWith<$Res> {
  _$HUDStateDoneCopyWithImpl(
      HUDStateDone _value, $Res Function(HUDStateDone) _then)
      : super(_value, (v) => _then(v as HUDStateDone));

  @override
  HUDStateDone get _value => super._value as HUDStateDone;
}

/// @nodoc

class _$HUDStateDone with DiagnosticableTreeMixin implements HUDStateDone {
  const _$HUDStateDone();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HUDState.done()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HUDState.done'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HUDStateDone);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Duration? duration) toast,
    required TResult Function() loading,
    required TResult Function() done,
  }) {
    return done();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? loading,
    TResult Function()? done,
  }) {
    return done?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Duration? duration)? toast,
    TResult Function()? loading,
    TResult Function()? done,
    required TResult orElse(),
  }) {
    if (done != null) {
      return done();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HUDStateToast value) toast,
    required TResult Function(HUDStateLoading value) loading,
    required TResult Function(HUDStateDone value) done,
  }) {
    return done(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HUDStateToast value)? toast,
    TResult Function(HUDStateLoading value)? loading,
    TResult Function(HUDStateDone value)? done,
  }) {
    return done?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HUDStateToast value)? toast,
    TResult Function(HUDStateLoading value)? loading,
    TResult Function(HUDStateDone value)? done,
    required TResult orElse(),
  }) {
    if (done != null) {
      return done(this);
    }
    return orElse();
  }
}

abstract class HUDStateDone implements HUDState {
  const factory HUDStateDone() = _$HUDStateDone;
}
