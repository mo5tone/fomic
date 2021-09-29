// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'manga_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MangaInfoTearOff {
  const _$MangaInfoTearOff();

  _MangaInfo call(String key, String title,
      {String artist = '',
      String author = '',
      String description = '',
      List<String> genres = const [],
      MangaInfoStatus status = MangaInfoStatus.unknown,
      String cover = ''}) {
    return _MangaInfo(
      key,
      title,
      artist: artist,
      author: author,
      description: description,
      genres: genres,
      status: status,
      cover: cover,
    );
  }
}

/// @nodoc
const $MangaInfo = _$MangaInfoTearOff();

/// @nodoc
mixin _$MangaInfo {
  String get key => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;
  MangaInfoStatus get status => throw _privateConstructorUsedError;
  String get cover => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MangaInfoCopyWith<MangaInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaInfoCopyWith<$Res> {
  factory $MangaInfoCopyWith(MangaInfo value, $Res Function(MangaInfo) then) =
      _$MangaInfoCopyWithImpl<$Res>;
  $Res call(
      {String key,
      String title,
      String artist,
      String author,
      String description,
      List<String> genres,
      MangaInfoStatus status,
      String cover});
}

/// @nodoc
class _$MangaInfoCopyWithImpl<$Res> implements $MangaInfoCopyWith<$Res> {
  _$MangaInfoCopyWithImpl(this._value, this._then);

  final MangaInfo _value;
  // ignore: unused_field
  final $Res Function(MangaInfo) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? title = freezed,
    Object? artist = freezed,
    Object? author = freezed,
    Object? description = freezed,
    Object? genres = freezed,
    Object? status = freezed,
    Object? cover = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: artist == freezed
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      genres: genres == freezed
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MangaInfoStatus,
      cover: cover == freezed
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MangaInfoCopyWith<$Res> implements $MangaInfoCopyWith<$Res> {
  factory _$MangaInfoCopyWith(
          _MangaInfo value, $Res Function(_MangaInfo) then) =
      __$MangaInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String key,
      String title,
      String artist,
      String author,
      String description,
      List<String> genres,
      MangaInfoStatus status,
      String cover});
}

/// @nodoc
class __$MangaInfoCopyWithImpl<$Res> extends _$MangaInfoCopyWithImpl<$Res>
    implements _$MangaInfoCopyWith<$Res> {
  __$MangaInfoCopyWithImpl(_MangaInfo _value, $Res Function(_MangaInfo) _then)
      : super(_value, (v) => _then(v as _MangaInfo));

  @override
  _MangaInfo get _value => super._value as _MangaInfo;

  @override
  $Res call({
    Object? key = freezed,
    Object? title = freezed,
    Object? artist = freezed,
    Object? author = freezed,
    Object? description = freezed,
    Object? genres = freezed,
    Object? status = freezed,
    Object? cover = freezed,
  }) {
    return _then(_MangaInfo(
      key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: artist == freezed
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      genres: genres == freezed
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MangaInfoStatus,
      cover: cover == freezed
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MangaInfo with DiagnosticableTreeMixin implements _MangaInfo {
  _$_MangaInfo(this.key, this.title,
      {this.artist = '',
      this.author = '',
      this.description = '',
      this.genres = const [],
      this.status = MangaInfoStatus.unknown,
      this.cover = ''});

  @override
  final String key;
  @override
  final String title;
  @JsonKey(defaultValue: '')
  @override
  final String artist;
  @JsonKey(defaultValue: '')
  @override
  final String author;
  @JsonKey(defaultValue: '')
  @override
  final String description;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> genres;
  @JsonKey(defaultValue: MangaInfoStatus.unknown)
  @override
  final MangaInfoStatus status;
  @JsonKey(defaultValue: '')
  @override
  final String cover;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaInfo(key: $key, title: $title, artist: $artist, author: $author, description: $description, genres: $genres, status: $status, cover: $cover)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaInfo'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('artist', artist))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('genres', genres))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('cover', cover));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MangaInfo &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.artist, artist) ||
                const DeepCollectionEquality().equals(other.artist, artist)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.genres, genres) ||
                const DeepCollectionEquality().equals(other.genres, genres)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.cover, cover) ||
                const DeepCollectionEquality().equals(other.cover, cover)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(artist) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(genres) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(cover);

  @JsonKey(ignore: true)
  @override
  _$MangaInfoCopyWith<_MangaInfo> get copyWith =>
      __$MangaInfoCopyWithImpl<_MangaInfo>(this, _$identity);
}

abstract class _MangaInfo implements MangaInfo {
  factory _MangaInfo(String key, String title,
      {String artist,
      String author,
      String description,
      List<String> genres,
      MangaInfoStatus status,
      String cover}) = _$_MangaInfo;

  @override
  String get key => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get artist => throw _privateConstructorUsedError;
  @override
  String get author => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  List<String> get genres => throw _privateConstructorUsedError;
  @override
  MangaInfoStatus get status => throw _privateConstructorUsedError;
  @override
  String get cover => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MangaInfoCopyWith<_MangaInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
