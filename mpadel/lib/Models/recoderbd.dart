import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:Klasspadel/Common/hive_constant_adapterInit.dart';

part 'recoderbd.g.dart';

@HiveType(typeId: HiveConstantAdapterInit.idRecodedDBAdapter)
class RecodedBD {
  RecodedBD(
      {required this.timeMs,
      required this.titleThumb,
      required this.timeRecoded,
      required this.recoderUrl});

  @HiveField(0)
  int timeMs;
  @HiveField(1)
  String titleThumb;
  @HiveField(2)
  DateTime timeRecoded;

  @HiveField(3)
  Uint8List? recoderUrl;
}
