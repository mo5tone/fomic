// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaInfoStatusAdapter extends TypeAdapter<MangaInfoStatus> {
  @override
  final int typeId = 0;

  @override
  MangaInfoStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MangaInfoStatus.unknown;
      case 1:
        return MangaInfoStatus.ongoing;
      case 2:
        return MangaInfoStatus.completed;
      case 3:
        return MangaInfoStatus.licensed;
      case 4:
        return MangaInfoStatus.publishingFinished;
      case 5:
        return MangaInfoStatus.cancelled;
      case 6:
        return MangaInfoStatus.onHiatus;
      default:
        return MangaInfoStatus.unknown;
    }
  }

  @override
  void write(BinaryWriter writer, MangaInfoStatus obj) {
    switch (obj) {
      case MangaInfoStatus.unknown:
        writer.writeByte(0);
        break;
      case MangaInfoStatus.ongoing:
        writer.writeByte(1);
        break;
      case MangaInfoStatus.completed:
        writer.writeByte(2);
        break;
      case MangaInfoStatus.licensed:
        writer.writeByte(3);
        break;
      case MangaInfoStatus.publishingFinished:
        writer.writeByte(4);
        break;
      case MangaInfoStatus.cancelled:
        writer.writeByte(5);
        break;
      case MangaInfoStatus.onHiatus:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaInfoStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
