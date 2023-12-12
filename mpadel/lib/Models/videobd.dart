import 'dart:typed_data';

import 'package:Klasspadel/Models/recoderbd.dart';
import 'package:Klasspadel/Models/thumbnailbd.dart';

import 'package:hive/hive.dart';
import 'package:Klasspadel/Common/hive_constant_adapterInit.dart';

part 'videobd.g.dart';

@HiveType(typeId: HiveConstantAdapterInit.idVideoDBAdapter)
class VideoBD {
  VideoBD(
      {required this.urlVideo,
      required this.title,
      required this.descriptionVideo,
      required this.name,
      required this.imgage,
      required this.time,
      required this.listThumbnail,
      required this.timeRecoded,
      required this.listRecoded});

  @HiveField(0)
  String urlVideo;
  @HiveField(1)
  String title;
  @HiveField(2)
  String descriptionVideo;
  @HiveField(3)
  String name;
  @HiveField(4)
  Uint8List imgage;
  @HiveField(5)
  String time;
  @HiveField(6)
  List<ThumbnailBD> listThumbnail;
  @HiveField(7)
  DateTime timeRecoded;
  @HiveField(8)
  List<RecodedBD>? listRecoded;
}
