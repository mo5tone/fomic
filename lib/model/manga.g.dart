// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaAdapter extends TypeAdapter<Manga> {
  @override
  final int typeId = 1;

  @override
  Manga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Manga(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      fields[3] as String,
      artist: fields[4] as String,
      author: fields[5] as String,
      description: fields[6] as String,
      genres: (fields[7] as List).cast<String>(),
      status: fields[8] as MangaInfoStatus,
      cover: fields[9] as String,
      customCover: fields[10] as String,
      favorite: fields[11] as bool,
      lastUpdate: fields[12] as int,
      lastInit: fields[13] as int,
      viewer: fields[14] as int,
      flags: fields[15] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Manga obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.source)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.artist)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.genres)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.cover)
      ..writeByte(10)
      ..write(obj.customCover)
      ..writeByte(11)
      ..write(obj.favorite)
      ..writeByte(12)
      ..write(obj.lastUpdate)
      ..writeByte(13)
      ..write(obj.lastInit)
      ..writeByte(14)
      ..write(obj.viewer)
      ..writeByte(15)
      ..write(obj.flags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
