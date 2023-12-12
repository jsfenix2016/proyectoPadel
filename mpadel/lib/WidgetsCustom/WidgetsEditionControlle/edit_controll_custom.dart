import 'dart:io' as io;
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:Klasspadel/Models/recoded_model.dart';
import 'package:Klasspadel/Models/thumbnail.dart';
import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:Klasspadel/Page/EditVideo/PageView/editVideoScreen.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/container_list_recoder.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/edit_button_expand.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/recoded_count.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/zoom_custom.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:painter/painter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class EditControllCustom extends StatefulWidget {
  const EditControllCustom(
      {super.key,
      required this.onChanged,
      required this.onDelete,
      required this.listThumb,
      required this.onShowThumb,
      required this.nameAudio,
      required this.onSavePublish});

  static PainterController newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  final List<Thumbnail> listThumb;
  final ValueChanged<Thumbnail> onChanged;
  final ValueChanged<int> onDelete;
  final ValueChanged<int> onShowThumb;
  final ValueChanged<bool> onSavePublish;
  final String nameAudio;
  @override
  State<EditControllCustom> createState() => _EditControllCustomState();
}

class _EditControllCustomState extends State<EditControllCustom> {
  late PainterController controller = EditControllCustom.newController();
  WidgetsToImageController controllerWidget = WidgetsToImageController();
  late FlutterSoundRecorder _recordingSession;
  late AssetsAudioPlayer recordingPlayer = AssetsAudioPlayer();
  String pathToAudio = '';

  int elapsedTime = 0;

  List<Thumbnail> listRecoded = [];
  Thumbnail? thumbnailTemp;
  bool isrecoded = false;
  bool zoomActived = false;
  bool isedit = false;
  bool showlist = false;
  io.Directory? directory;

  @override
  void initState() {
    super.initState();
    listRecoded = widget.listThumb;
    initThumbnails();
    initializerRecoder();
  }

  void initThumbnails() {
    thumbnailTemp = Thumbnail(
        timeMs: 0.toString(),
        imageUrl: Uint8List(0),
        descriptionThumb: "",
        titleThumb: "",
        timeCapture: DateTime.now().toIso8601String(),
        pathRecoded: '',
        timeDurationRecoded: '',
        titleRecoded: '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initializerRecoder() async {
    thumbnailTemp = Thumbnail(
        timeMs: 0.toString(),
        imageUrl: Uint8List(0),
        descriptionThumb: "",
        titleThumb: "",
        timeCapture: DateTime.now().toIso8601String(),
        pathRecoded: '',
        timeDurationRecoded: '',
        titleRecoded: '');
    io.Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory();

    String filePath = '${appDocumentsDirectory.path}/${widget.nameAudio}.wav';
    File newVideoFile = File(filePath);
    pathToAudio = newVideoFile.path;
    // pathToAudio = '/sdcard/Download/$nameAudio.wav';
    _recordingSession = FlutterSoundRecorder();
    thumbnailTemp!.pathRecoded = pathToAudio;
    await _recordingSession.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _recordingSession
        .setSubscriptionDuration(const Duration(minutes: 10));
    await initializeDateFormatting();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> startRecording() async {
    elapsedTime = 0;
    io.Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/${widget.nameAudio}.wav';
    File newVideoFile = File(filePath);
    pathToAudio = newVideoFile.path;
    if (!appDocumentsDirectory.existsSync()) {
      appDocumentsDirectory.createSync();
    }
    print(filePath);
    thumbnailTemp!.pathRecoded = filePath;
    _recordingSession.openAudioSession();
    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );
  }

  processVideoThumbnail() async {
    final bytes = await controllerWidget.capture();
    thumbnailTemp!.imageUrl = bytes;
    thumbnailTemp!.timeDurationRecoded = elapsedTime.toString();

    print(thumbnailTemp!.pathRecoded);
    controller.clear();
    widget.onChanged(thumbnailTemp!);
  }

  Future<String?> stopRecording() async {
    _recordingSession.closeAudioSession();
    processVideoThumbnail();

    return await _recordingSession.stopRecorder();
  }

  void publishVideo() async {
    widget.onSavePublish(true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          WidgetsToImage(
            controller: controllerWidget,
            child: (isedit) ? Painter(controller) : const SizedBox.shrink(),
          ),
          ZoomCustom(
            zoomActived: zoomActived,
          ),
          // Container(
          //   color: Colors.red,
          //   height: 80,
          //   width: size.width,
          //   child: PreferredSize(
          //     preferredSize: Size(MediaQuery.of(context).size.width, 20.0),
          //     child: DrawBar(controller, isedit, (bool value) {
          //       isedit = value;
          //       setState(() {});
          //     }),
          //   ),
          // ),
          Visibility(
            visible: showlist,
            child: ContainerListRecoder(
              listThumbnail: widget.listThumb,
              onDelete: (int value) {
                // listRecoded.removeAt(value);
                widget.onDelete(value);
              },
              onShowThumb: (int value) {
                widget.onShowThumb(value);
              },
              onClose: (bool value) {
                showlist = false;
                setState(() {});
              },
            ),
          ),
          EditButtonExpand(
            onChanged: (PainterController value) {
              controller = value;

              if (isedit) {
                isedit = false;
              } else {
                isedit = true;
              }

              setState(() {});
            },
            onDelete: (bool value) {
              controller.clear;
              setState(() {});
            },
            onUndo: (void value) async {
              if (controller.isEmpty) {
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => const SizedBox(
                    height: 20,
                    child: Center(
                      child: Text('No tienes cambios'),
                    ),
                  ),
                );
              } else {
                controller.undo();
              }
            },
            onZoom: (bool value) {
              if (value) {
                zoomActived = false;
              } else {
                zoomActived = true;
              }
              setState(() {});
            },
            onPreview: (value) {
              publishVideo();
            },
            onList: (bool value) {
              if (showlist) {
                showlist = false;
              } else {
                showlist = true;
              }
              setState(() {});
            },
          ),

          Visibility(
            visible: !showlist,
            child: Positioned(
              right: 10,
              child: RecoderCount(
                onChanged: (Duration value) async {
                  if (value.inSeconds == 0) {
                    startRecording();
                    isrecoded = true;
                  } else {
                    isrecoded = false;
                    elapsedTime = value.inSeconds;

                    await stopRecording();
                  }
                },
              ),
            ),
          ),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              //     IconButton(
              //       icon: Container(
              //         height: 40.0,
              //         width: 60,
              //         decoration: BoxDecoration(
              //           color: Colors.white.withAlpha(70),
              //           border: Border.all(
              //               color: const Color.fromRGBO(219, 177, 42, 1)),
              //           borderRadius: const BorderRadius.all(Radius.circular(20)),
              //         ),
              //         child: const Icon(
              //           Icons.edit,
              //           color: Colors.black,
              //         ),
              //       ),
              //       tooltip: 'editshowmenu',
              //       onPressed: () {
              //         showModalBottomSheet(
              //           context: context,
              //           builder: (BuildContext context) => SizedBox(
              //             height: 300,
              //             child: DefaultTabController(
              //               length: 2,
              //               child: Column(
              //                 children: [
              //                   const TabBar(
              //                     tabs: [
              //                       Tab(
              //                         child: Text(
              //                           'Edición',
              //                           style: TextStyle(
              //                               color: Colors.black,
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                       ),
              //                       Tab(
              //                         child: Text(
              //                           'Lista grabación',
              //                           style: TextStyle(
              //                               color: Colors.black,
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   Expanded(
              //                     child: TabBarView(
              //                       children: [
              //                         Container(
              //                           color: Colors.amber,
              //                           child: Center(
              //                             child: Row(
              //                               children: [
              //                                 Column(
              //                                   children: [
              //                                     Container(
              //                                       width: size.width,
              //                                       height: 50,
              //                                       color: Colors.white,
              //                                       child: const Center(
              //                                         child: Text(
              //                                           'Menú para la edición de video',
              //                                           style: TextStyle(
              //                                               fontSize: 16,
              //                                               color: Colors.black,
              //                                               fontWeight:
              //                                                   FontWeight.bold),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                     Row(
              //                                       children: [
              //                                         // IconButton(
              //                                         //     icon: const Icon(
              //                                         //       Icons.undo,
              //                                         //     ),
              //                                         //     tooltip: 'Undo',
              //                                         //     onPressed: () async {
              //                                         //       if (controller
              //                                         //           .isEmpty) {
              //                                         //         await showModalBottomSheet(
              //                                         //           context: context,
              //                                         //           builder: (BuildContext
              //                                         //                   context) =>
              //                                         //               const SizedBox(
              //                                         //             height: 20,
              //                                         //             child: Center(
              //                                         //               child: Text(
              //                                         //                   'No tienes cambios'),
              //                                         //             ),
              //                                         //           ),
              //                                         //         );
              //                                         //       } else {
              //                                         //         controller.undo();
              //                                         //       }
              //                                         //     }),
              //                                         // IconButton(
              //                                         //     icon: const Icon(
              //                                         //         Icons.delete),
              //                                         //     tooltip: 'Clear',
              //                                         //     onPressed:
              //                                         //         controller.clear),
              //                                         IconButton(
              //                                           icon: const Icon(
              //                                               Icons.publish),
              //                                           onPressed: publishVideo,
              //                                         ),
              //                                         // IconButton(
              //                                         //   icon: const Icon(
              //                                         //       Icons.zoom_in),
              //                                         //   onPressed: () async {
              //                                         //     if (zoomActived) {
              //                                         //       zoomActived = false;
              //                                         //     } else {
              //                                         //       zoomActived = true;
              //                                         //     }
              //                                         //     setState(() {});
              //                                         //   },
              //                                         // ),
              //                                       ],
              //                                     ),
              //                                     Container(
              //                                       color: Colors.transparent,
              //                                       height: 80,
              //                                       width: size.width,
              //                                       child: PreferredSize(
              //                                         preferredSize: Size(
              //                                             MediaQuery.of(context)
              //                                                 .size
              //                                                 .width,
              //                                             20.0),
              //                                         child: DrawBar(
              //                                             controller, isedit,
              //                                             (bool value) {
              //                                           isedit = value;
              //                                           setState(() {});
              //                                         }),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              // ContainerListRecoder(
              //   listThumbnail: widget.listThumb,
              //   onDelete: (int value) {
              //     // listRecoded.removeAt(value);
              //     widget.onDelete(value);
              //   },
              //   onShowThumb: (int value) {
              //     widget.onShowThumb(value);
              //   },
              // ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
            ],
          ),
        ],
      ),
    );
  }
}
