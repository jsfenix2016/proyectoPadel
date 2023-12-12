import 'dart:io';

import 'package:Klasspadel/Common/hive_data.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/Home/Pageview/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveController extends GetxController {
  // final LoginService loginService = Get.put(LoginService());
  Future<bool> saveVideo(VideoBD video) async {
    final save = await const HiveData().saveVideo(video);

    // mostrarAlerta(context, "Se guardo correctamente");
    if (save) {
      return true;
    } else {
      return false;
    }
  }

  // Función para eliminar un archivo de video
  Future<void> deleteVideo(String videoPath) async {
    try {
      final file = File(videoPath);
      if (await file.exists()) {
        await file.delete();
        print('Video eliminado exitosamente.');
      } else {
        print('El video no existe en el dispositivo.');
      }
    } catch (e) {
      print('Error al eliminar el video: $e');
    }
  }
}
