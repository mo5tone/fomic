// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PageTearOff {
  const _$PageTearOff();

  PageUrl url(String url) {
    return PageUrl(
      url,
    );
  }

  PageImageUrl imageUrl(String url) {
    return PageImageUrl(
      url,
    );
  }

  PageImageBase64 imageBase64(String data) {
    return PageImageBase64(
      data,
    );
  }

  PageText text(String text) {
    return PageText(
      text,
    );
  }
}

/// @nodoc
const $Page = _$PageTearOff();

/// @nodoc
mixin _$Page {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) url,
    required TResult Function(String url) imageUrl,
    required TResult Function(String data) imageBase64,
    required TResult Function(String text) text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageUrl value) url,
    required TResult Function(PageImageUrl value) imageUrl,
    required TResult Function(PageImageBase64 value) imageBase64,
    required TResult Function(PageText value) text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageCopyWith<$Res> {
  factory $PageCopyWith(Page value, $Res Function(Page) then) =
      _$PageCopyWithImpl<$Res>;
}

/// @nodoc
class _$PageCopyWithImpl<$Res> implements $PageCopyWith<$Res> {
  _$PageCopyWithImpl(this._value, this._then);

  final Page _value;
  // ignore: unused_field
  final $Res Function(Page) _then;
}

/// @nodoc
abstract class $PageUrlCopyWith<$Res> {
  factory $PageUrlCopyWith(PageUrl value, $Res Function(PageUrl) then) =
      _$PageUrlCopyWithImpl<$Res>;
  $Res call({String url});
}

/// @nodoc
class _$PageUrlCopyWithImpl<$Res> extends _$PageCopyWithImpl<$Res>
    implements $PageUrlCopyWith<$Res> {
  _$PageUrlCopyWithImpl(PageUrl _value, $Res Function(PageUrl) _then)
      : super(_value, (v) => _then(v as PageUrl));

  @override
  PageUrl get _value => super._value as PageUrl;

  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(PageUrl(
      url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PageUrl with DiagnosticableTreeMixin implements PageUrl {
  const _$PageUrl(this.url);

  @override
  final String url;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Page.url(url: $url)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Page.url'))
      ..add(DiagnosticsProperty('url', url));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageUrl &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  $PageUrlCopyWith<PageUrl> get copyWith =>
      _$PageUrlCopyWithImpl<PageUrl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) url,
    required TResult Function(String url) imageUrl,
    required TResult Function(String data) imageBase64,
    required TResult Function(String text) text,
  }) {
    return url(this.url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
  }) {
    return url?.call(this.url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
    required TResult orElse(),
  }) {
    if (url != null) {
      return url(this.url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageUrl value) url,
    required TResult Function(PageImageUrl value) imageUrl,
    required TResult Function(PageImageBase64 value) imageBase64,
    required TResult Function(PageText value) text,
  }) {
    return url(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
  }) {
    return url?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
    required TResult orElse(),
  }) {
    if (url != null) {
      return url(this);
    }
    return orElse();
  }
}

abstract class PageUrl implements Page {
  const factory PageUrl(String url) = _$PageUrl;

  String get url;
  @JsonKey(ignore: true)
  $PageUrlCopyWith<PageUrl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageImageUrlCopyWith<$Res> {
  factory $PageImageUrlCopyWith(
          PageImageUrl value, $Res Function(PageImageUrl) then) =
      _$PageImageUrlCopyWithImpl<$Res>;
  $Res call({String url});
}

/// @nodoc
class _$PageImageUrlCopyWithImpl<$Res> extends _$PageCopyWithImpl<$Res>
    implements $PageImageUrlCopyWith<$Res> {
  _$PageImageUrlCopyWithImpl(
      PageImageUrl _value, $Res Function(PageImageUrl) _then)
      : super(_value, (v) => _then(v as PageImageUrl));

  @override
  PageImageUrl get _value => super._value as PageImageUrl;

  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(PageImageUrl(
      url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PageImageUrl with DiagnosticableTreeMixin implements PageImageUrl {
  const _$PageImageUrl(this.url);

  @override
  final String url;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Page.imageUrl(url: $url)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Page.imageUrl'))
      ..add(DiagnosticsProperty('url', url));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageImageUrl &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  $PageImageUrlCopyWith<PageImageUrl> get copyWith =>
      _$PageImageUrlCopyWithImpl<PageImageUrl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) url,
    required TResult Function(String url) imageUrl,
    required TResult Function(String data) imageBase64,
    required TResult Function(String text) text,
  }) {
    return imageUrl(this.url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
  }) {
    return imageUrl?.call(this.url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
    required TResult orElse(),
  }) {
    if (imageUrl != null) {
      return imageUrl(this.url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageUrl value) url,
    required TResult Function(PageImageUrl value) imageUrl,
    required TResult Function(PageImageBase64 value) imageBase64,
    required TResult Function(PageText value) text,
  }) {
    return imageUrl(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
  }) {
    return imageUrl?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
    required TResult orElse(),
  }) {
    if (imageUrl != null) {
      return imageUrl(this);
    }
    return orElse();
  }
}

abstract class PageImageUrl implements Page {
  const factory PageImageUrl(String url) = _$PageImageUrl;

  String get url;
  @JsonKey(ignore: true)
  $PageImageUrlCopyWith<PageImageUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageImageBase64CopyWith<$Res> {
  factory $PageImageBase64CopyWith(
          PageImageBase64 value, $Res Function(PageImageBase64) then) =
      _$PageImageBase64CopyWithImpl<$Res>;
  $Res call({String data});
}

/// @nodoc
class _$PageImageBase64CopyWithImpl<$Res> extends _$PageCopyWithImpl<$Res>
    implements $PageImageBase64CopyWith<$Res> {
  _$PageImageBase64CopyWithImpl(
      PageImageBase64 _value, $Res Function(PageImageBase64) _then)
      : super(_value, (v) => _then(v as PageImageBase64));

  @override
  PageImageBase64 get _value => super._value as PageImageBase64;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(PageImageBase64(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PageImageBase64
    with DiagnosticableTreeMixin
    implements PageImageBase64 {
  const _$PageImageBase64(this.data);

  @override
  final String data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Page.imageBase64(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Page.imageBase64'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageImageBase64 &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  $PageImageBase64CopyWith<PageImageBase64> get copyWith =>
      _$PageImageBase64CopyWithImpl<PageImageBase64>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) url,
    required TResult Function(String url) imageUrl,
    required TResult Function(String data) imageBase64,
    required TResult Function(String text) text,
  }) {
    return imageBase64(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
  }) {
    return imageBase64?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
    required TResult orElse(),
  }) {
    if (imageBase64 != null) {
      return imageBase64(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageUrl value) url,
    required TResult Function(PageImageUrl value) imageUrl,
    required TResult Function(PageImageBase64 value) imageBase64,
    required TResult Function(PageText value) text,
  }) {
    return imageBase64(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
  }) {
    return imageBase64?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
    required TResult orElse(),
  }) {
    if (imageBase64 != null) {
      return imageBase64(this);
    }
    return orElse();
  }
}

abstract class PageImageBase64 implements Page {
  const factory PageImageBase64(String data) = _$PageImageBase64;

  String get data;
  @JsonKey(ignore: true)
  $PageImageBase64CopyWith<PageImageBase64> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageTextCopyWith<$Res> {
  factory $PageTextCopyWith(PageText value, $Res Function(PageText) then) =
      _$PageTextCopyWithImpl<$Res>;
  $Res call({String text});
}

/// @nodoc
class _$PageTextCopyWithImpl<$Res> extends _$PageCopyWithImpl<$Res>
    implements $PageTextCopyWith<$Res> {
  _$PageTextCopyWithImpl(PageText _value, $Res Function(PageText) _then)
      : super(_value, (v) => _then(v as PageText));

  @override
  PageText get _value => super._value as PageText;

  @override
  $Res call({
    Object? text = freezed,
  }) {
    return _then(PageText(
      text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PageText with DiagnosticableTreeMixin implements PageText {
  const _$PageText(this.text);

  @override
  final String text;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Page.text(text: $text)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Page.text'))
      ..add(DiagnosticsProperty('text', text));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageText &&
            const DeepCollectionEquality().equals(other.text, text));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(text));

  @JsonKey(ignore: true)
  @override
  $PageTextCopyWith<PageText> get copyWith =>
      _$PageTextCopyWithImpl<PageText>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) url,
    required TResult Function(String url) imageUrl,
    required TResult Function(String data) imageBase64,
    required TResult Function(String text) text,
  }) {
    return text(this.text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
  }) {
    return text?.call(this.text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? url,
    TResult Function(String url)? imageUrl,
    TResult Function(String data)? imageBase64,
    TResult Function(String text)? text,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this.text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageUrl value) url,
    required TResult Function(PageImageUrl value) imageUrl,
    required TResult Function(PageImageBase64 value) imageBase64,
    required TResult Function(PageText value) text,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageUrl value)? url,
    TResult Function(PageImageUrl value)? imageUrl,
    TResult Function(PageImageBase64 value)? imageBase64,
    TResult Function(PageText value)? text,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class PageText implements Page {
  const factory PageText(String text) = _$PageText;

  String get text;
  @JsonKey(ignore: true)
  $PageTextCopyWith<PageText> get copyWith =>
      throw _privateConstructorUsedError;
}
