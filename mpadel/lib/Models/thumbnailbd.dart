import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:Klasspadel/Common/hive_constant_adapterInit.dart';

part 'thumbnailbd.g.dart';

@HiveType(typeId: HiveConstantAdapterInit.idThumbnailDBAdapter)
class ThumbnailBD {
  ThumbnailBD(
      {required this.timeMs,
      required this.imageUrl,
      required this.titleThumb,
      required this.descriptionThumb,
      required this.timeCapture,
      required this.recoderUrl,
      required this.timeDurationRecoded,
      required this.titleRecoded,
      required this.recoderPath});

  @HiveField(0)
  int timeMs;
  @HiveField(1)
  Uint8List imageUrl;
  @HiveField(2)
  String descriptionThumb;
  @HiveField(3)
  String titleThumb;
  @HiveField(4)
  DateTime timeCapture;
  @HiveField(5)
  Uint8List? recoderUrl;
  @HiveField(6)
  String timeDurationRecoded;
  @HiveField(7)
  String titleRecoded;
  @HiveField(8)
  String? recoderPath;
}
