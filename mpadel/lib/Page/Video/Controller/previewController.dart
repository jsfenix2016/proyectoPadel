import 'package:Klasspadel/Common/hive_data.dart';
import 'package:Klasspadel/Models/videobd.dart';

import 'package:get/get.dart';

class PreviewController extends GetxController {
  Future<bool> saveVideo(VideoBD video) async {
    final save = await const HiveData().saveVideo(video);

    // mostrarAlerta(context, "Se guardo correctamente");
    if (save) {
      return true;
    } else {
      return false;
    }
  }
}
