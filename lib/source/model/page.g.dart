// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PageAdapter extends TypeAdapter<Page> {
  @override
  final int typeId = 2;

  @override
  Page read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Page(
      index: fields[0] as int,
      imageUrl: fields[1] as String,
      imageHeaders: (fields[2] as Map)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Page obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.imageHeaders);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PageAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
