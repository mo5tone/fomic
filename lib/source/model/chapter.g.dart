// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterAdapter extends TypeAdapter<Chapter> {
  @override
  final int typeId = 1;

  @override
  Chapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chapter(
      fields[0] as String,
      index: fields[3] as double,
      name: fields[1] as String,
      updatedAt: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Chapter obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChapterAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
