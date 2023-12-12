import 'dart:io';

import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Klasspadel/Models/userbd.dart';
import 'package:Klasspadel/Models/videobd.dart';

import 'package:path_provider/path_provider.dart';

class HiveConstantAdapterInit {
  static const int idUserDBAdapter = 0;
  static const int idVideoDBAdapter = 1;
  static const int idThumbnailDBAdapter = 2;
  static const int idRecodedDBAdapter = 3;
}

Future<void> inicializeHiveBD() async {
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDirectory.path);
  if (!Hive.isAdapterRegistered(UserBDAdapter().typeId)) {
    Hive.registerAdapter(UserBDAdapter());
  }
  if (!Hive.isAdapterRegistered(VideoBDAdapter().typeId)) {
    Hive.registerAdapter(VideoBDAdapter());
  }
  if (!Hive.isAdapterRegistered(ThumbnailBDAdapter().typeId)) {
    Hive.registerAdapter(ThumbnailBDAdapter());
  }
}
