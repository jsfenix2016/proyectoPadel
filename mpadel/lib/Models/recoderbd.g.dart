// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recoderbd.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecodedBDAdapter extends TypeAdapter<RecodedBD> {
  @override
  final int typeId = 3;

  @override
  RecodedBD read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecodedBD(
      timeMs: fields[0] as int,
      titleThumb: fields[1] as String,
      timeRecoded: fields[2] as DateTime,
      recoderUrl: fields[3] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, RecodedBD obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.timeMs)
      ..writeByte(1)
      ..write(obj.titleThumb)
      ..writeByte(2)
      ..write(obj.timeRecoded)
      ..writeByte(3)
      ..write(obj.recoderUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecodedBDAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
