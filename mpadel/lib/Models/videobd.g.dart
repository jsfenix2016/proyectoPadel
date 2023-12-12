// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videobd.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoBDAdapter extends TypeAdapter<VideoBD> {
  @override
  final int typeId = 1;

  @override
  VideoBD read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoBD(
      urlVideo: fields[0] as String,
      title: fields[1] as String,
      descriptionVideo: fields[2] as String,
      name: fields[3] as String,
      imgage: fields[4] as Uint8List,
      time: fields[5] as String,
      listThumbnail: (fields[6] as List).cast<ThumbnailBD>(),
      timeRecoded: fields[7] as DateTime,
      listRecoded: (fields[8] as List?)?.cast<RecodedBD>(),
    );
  }

  @override
  void write(BinaryWriter writer, VideoBD obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.urlVideo)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.descriptionVideo)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.imgage)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.listThumbnail)
      ..writeByte(7)
      ..write(obj.timeRecoded)
      ..writeByte(8)
      ..write(obj.listRecoded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoBDAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
