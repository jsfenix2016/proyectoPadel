// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnailbd.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThumbnailBDAdapter extends TypeAdapter<ThumbnailBD> {
  @override
  final int typeId = 2;

  @override
  ThumbnailBD read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThumbnailBD(
      timeMs: fields[0] as int,
      imageUrl: fields[1] as Uint8List,
      titleThumb: fields[3] as String,
      descriptionThumb: fields[2] as String,
      timeCapture: fields[4] as DateTime,
      recoderUrl: fields[5] as Uint8List?,
      timeDurationRecoded: fields[6] as String,
      titleRecoded: fields[7] as String,
      recoderPath: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ThumbnailBD obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.timeMs)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.descriptionThumb)
      ..writeByte(3)
      ..write(obj.titleThumb)
      ..writeByte(4)
      ..write(obj.timeCapture)
      ..writeByte(5)
      ..write(obj.recoderUrl)
      ..writeByte(6)
      ..write(obj.timeDurationRecoded)
      ..writeByte(7)
      ..write(obj.titleRecoded)
      ..writeByte(8)
      ..write(obj.recoderPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThumbnailBDAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
