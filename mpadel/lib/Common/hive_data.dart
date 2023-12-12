import 'package:Klasspadel/Models/userbd.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveData {
  const HiveData();

  Future<bool> updateVideo(VideoBD video) async {
    try {
      final Box<VideoBD> box = await Hive.openBox<VideoBD>('VideoBD');
      var index = 0;
      for (var contactRiskBD in box.values.toList()) {
        if (contactRiskBD.urlVideo == video.urlVideo) {
          await box.putAt(index, video);
          break;
        }
        index++;
      }
      // await box.put(video.descriptionVideo, video);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveVideo(VideoBD video) async {
    try {
      final Box<VideoBD> box = await Hive.openBox<VideoBD>('VideoBD');

      final person = await box.add(video);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<List<VideoBD>> getAllMyVideo() async {
    try {
      final Box<VideoBD> box = await Hive.openBox<VideoBD>('VideoBD');

      return box.values.toList();
    } catch (error) {
      return [];
    }
  }
}
