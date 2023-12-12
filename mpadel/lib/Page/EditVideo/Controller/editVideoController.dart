import 'dart:typed_data';

import 'package:Klasspadel/Common/hive_data.dart';
import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/EditVideo/Service/edit_video_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:painter/painter.dart';
import 'package:video_player/video_player.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class EditVideoController extends GetxController {
  late VideoPlayerController videoPlayerController;

  late PainterController controller = newController();
// WidgetsToImageController to access widget
  WidgetsToImageController controllerWidget = WidgetsToImageController();
// to save image bytes of widget
  Uint8List? bytesImg;
  Uint8List? bytesRecoder = Uint8List(0);
  late List<Uint8List> listimg = [];
  late List<ThumbnailBD> listThumbnail = [];
  late ThumbnailBD thumbnailSelect;

  String elapsedTimeString = '';
  String title = '';
  String descripVideo = '';
  String alumno = '';
  String mode = 'Line';

  late Future<void> initializeVideoPlayerFuture;
  late Stream<double> videoPositionStream;

  List<List<Offset>> linesList = [];
  List<List<Offset>> undoLinesList = []; // Mover la inicialización aquí
  List<Offset> pointsList = [];
  List<Offset> points = <Offset>[];

  bool finished = false;
  bool isSelectThumb = false;
  bool isloading = false;
  bool isEdit = false;
  late EditVideoService editService = Get.put(EditVideoService());
  late VideoBD videoTemp;

  late int timeEdit;

  static PainterController newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  Future<bool> updateImagComments(VideoBD video) async {
    final save = await const HiveData().updateVideo(video);

    if (save) {
      return true;
    } else {
      return false;
    }
  }
}
