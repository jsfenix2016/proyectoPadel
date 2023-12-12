import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/EditVideo/Controller/editVideoController.dart';
import 'package:Klasspadel/WidgetsCustom/barPlayer.dart';
import 'package:Klasspadel/WidgetsCustom/loading_custom.dart';
import 'package:Klasspadel/WidgetsCustom/tableListThumbnails.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:notification_center/notification_center.dart';
import 'package:video_player/video_player.dart';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:painter/painter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditVideoPage extends StatefulWidget {
  final VideoBD item;

  const EditVideoPage({Key? key, required this.item}) : super(key: key);

  @override
  State<EditVideoPage> createState() => _EditVideoPageState();
}

class _EditVideoPageState extends State<EditVideoPage>
    with SingleTickerProviderStateMixin {
  final EditVideoController editCV = Get.put(EditVideoController());
  List<Image> listThumb = [];
  // bool isVisibleBrush = false;
  // bool isVisibleColors = false;
  // bool isVisibleSave = false;
  // bool isOpen = false;

  // Offset pointTemp = Offset.zero;
  // Offset pointTempInit = Offset.zero;

  // List<Color> undoLineColors = []; // Lista de puntos que representan las líneas
  // List<Color> lineColors = []; // Lista para mantener de colores utilizados
  // List<double> lineWidths = [];
  // List<double> undoLineWidths = [];

  // MyCustomBrushPainter myCustomBrushPainter = MyCustomBrushPainter(
  //     linesList: [], // Llenar con los datos necesarios
  //     lineWidths: [], // Llenar con los datos necesarios
  //     offset: Offset.zero, // Llenar con los datos necesarios
  //     offsetInit: Offset.zero, // Llenar con los datos necesarios
  //     pointsList: [], // Llenar con los datos necesarios
  //     lineColors: [],
  //     undoLineColors: [],
  //     undoLinesList: [],
  //     undoLineWidths: [], // Llenar con los datos necesarios
  //     drawingShape: DrawingShape.rectangle);

  // double value = 20;
  // double position = -170.0;

  // int selectOption = 0;

  @override
  void initState() {
    initThumbnails();
    editCV.videoPlayerController =
        VideoPlayerController.file(File(widget.item.urlVideo));
    showThumb();
    editCV.initializeVideoPlayerFuture =
        editCV.videoPlayerController.initialize();
    editCV.videoPositionStream =
        Stream<double>.periodic(const Duration(milliseconds: 200), (_) {
      return editCV.videoPlayerController.value.position.inMilliseconds
          .toDouble();
    }).takeWhile((position) {
      return editCV.videoPlayerController.value.isPlaying &&
          position <=
              editCV.videoPlayerController.value.duration.inMilliseconds
                  .toDouble();
    });
    editCV.videoTemp = widget.item;
    editCV.videoPlayerController.play();

    NotificationCenter().subscribe("myNotification", (int value) {
      // print(
      //     "${value.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(value.inSeconds).toString().padLeft(2, '0')}");
    });

    // _controllerGift = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 1),
    // )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    NotificationCenter()
        .unsubscribe("myNotification", callback: _onNotificationReceived);
    editCV.controller.dispose();
    // _controllerGift.dispose();
    editCV.videoPlayerController.dispose();

    super.dispose();
  }

  Future<bool> updateChangeEdit() async {
    print(editCV.videoPlayerController.value.duration.inMilliseconds);
    editCV.videoTemp.listThumbnail = editCV.listThumbnail.cast<ThumbnailBD>();
    return await editCV.updateImagComments(editCV.videoTemp);
  }

  void _onNotificationReceived(Notification notification) {
    // Manejar la notificación recibida
  }

  void showThumb() async {
    listThumb = await generateThumbnails(File(widget.item.urlVideo).path);
    setState(() {});
  }

  Future initThumbnails() async {
    Uint8List uint8list = await loadImage('assets/images/imageDraw.png');
    editCV.thumbnailSelect = ThumbnailBD(
        timeMs: 0,
        imageUrl: uint8list,
        descriptionThumb: "",
        titleThumb: "",
        timeCapture: DateTime.now(),
        recoderUrl: editCV.bytesRecoder,
        recoderPath: '',
        timeDurationRecoded: '',
        titleRecoded: '');
  }

  void showAlertContentInfo() async {
    var descripThumb = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(10),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.memory(
                editCV.bytesImg!,
                fit: BoxFit.cover,
                height: 250,
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  editCV.title = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  descripThumb = value;
                },
                maxLines: 10, // Permite múltiples líneas de texto
                decoration: const InputDecoration(
                  hintText: 'Texto largo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      editCV.finished = true;
                      editCV.isloading = false;
                      setState(() {});
                      // Acción al presionar el botón
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón
                      setState(() {
                        editCV.listimg.add(editCV.bytesImg!);
                        ThumbnailBD thumbnail = ThumbnailBD(
                          timeMs: editCV.videoPlayerController.value.position
                              .inMilliseconds,
                          imageUrl: editCV.bytesImg!,
                          titleThumb: editCV.title,
                          descriptionThumb: descripThumb,
                          timeCapture: DateTime.now(),
                          recoderUrl: editCV.bytesRecoder!,
                          recoderPath: '',
                          timeDurationRecoded: '',
                          titleRecoded: '',
                        );

                        editCV.listThumbnail.add(thumbnail);

                        editCV.finished = true;
                        Navigator.pop(context);
                      });
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  processVideoThumbnail(SendPort senPort) async {
    final bytes = await editCV.controllerWidget.capture();

    // senPort.send();
  }

  Future<List<Image>> generateThumbnails(String videoUrl) async {
    final List<Image> thumbnails = [];
    const int thumbnailCount = 30; // Número de miniaturas que deseas generar

    for (int i = 0; i < thumbnailCount; i++) {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 50,
        quality: 70,
        timeMs: (i * 1000), // Obtener miniaturas en intervalos de 1 segundo
      );

      if (uint8list!.isNotEmpty) {
        final image = Image.memory(
          uint8list,
          fit: BoxFit.cover,
        );
        thumbnails.add(image);
      }
    }

    return thumbnails;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    final size = MediaQuery.of(context).size;
    actions = <Widget>[
      IconButton(
          icon: const Icon(
            Icons.undo,
          ),
          tooltip: 'Undo',
          onPressed: () async {
            if (editCV.controller.isEmpty) {
              await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => const SizedBox(
                      height: 20,
                      child: Center(child: Text('No tienes cambios'))));
            } else {
              editCV.controller.undo();
            }
          }),
      IconButton(
          icon: const Icon(Icons.delete),
          tooltip: 'Clear',
          onPressed: editCV.controller.clear),
      IconButton(
        icon: const Icon(Icons.save),
        onPressed: () async {
          editCV.isloading = true;
          setState(() {});
          editCV.videoPlayerController.pause();
          final bytes = await editCV.controllerWidget.capture();
          editCV.isloading = false;
          var title = "";
          editCV.bytesImg = bytes;
          showAlertContentInfo();
        },
      ),
    ];
    // }
    return WillPopScope(
      onWillPop: () async {
        // Aquí puedes ejecutar acciones personalizadas antes de volver atrás
        // Por ejemplo, mostrar un diálogo de confirmación

        bool confirmExit = await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Confirmar'),
            content: const Text('¿Deseas guardar los cambios?'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.cancel,
                ),
                tooltip: 'Cancelar',
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.save,
                ),
                tooltip: 'save',
                onPressed: () async {
                  if (await updateChangeEdit()) {
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ],
          ),
        );
        editCV.isloading = false;
        setState(() {});
        return confirmExit;
      },
      child: Scaffold(
        bottomNavigationBar: BarPlayer(
          videoPlayerController: editCV.videoPlayerController,
          videoPositionStream: editCV.videoPositionStream,
          thumbnails: editCV.listThumbnail,
          onChangedThum: (ThumbnailBD value) {
            editCV.videoPlayerController.pause();
            editCV.isSelectThumb = true;
            editCV.thumbnailSelect = value;
          },
          onChangedTimeThumbnail: (int value) {
            editCV.timeEdit = value;
            editCV.isSelectThumb = false;
            editCV.controller = EditVideoController.newController();
            setState(() {});
          },
        ),
        appBar: AppBar(
          title: const Text('Editar video'),
          elevation: 0,
          backgroundColor: Colors.black26,
          actions: editCV.isEdit
              ? actions
              : <Widget>[
                  IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit',
                      onPressed: () {
                        setState(() {
                          editCV.videoPlayerController.pause();
                          editCV.isEdit = true;
                        });
                      })
                ],
          bottom: PreferredSize(
            preferredSize: editCV.isEdit
                ? Size(MediaQuery.of(context).size.width, 20.0)
                : Size(MediaQuery.of(context).size.width, 0.0),
            child: editCV.isEdit
                ? DrawBar(editCV.controller, editCV.isEdit, (bool value) {
                    print("object");
                  })
                : const SizedBox.shrink(),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  color: Colors.transparent,
                  width: size.width,
                  height:
                      editCV.isEdit ? (size.height - 181) : (size.height - 161),
                  child: Stack(
                    children: [
                      FutureBuilder(
                        future: editCV.initializeVideoPlayerFuture,
                        builder: (context, state) {
                          if (state.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: LoadingCustom());
                          } else {
                            if (editCV
                                .videoPlayerController.value.isInitialized) {
                              Duration elapsedTimeTemp = Duration(
                                  seconds: editCV.videoPlayerController.value
                                      .duration.inSeconds);
                              // var a = format.format(Duration(seconds: _elapsedTime));
                              editCV.elapsedTimeString =
                                  "${elapsedTimeTemp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(elapsedTimeTemp.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
                            }
                            return WidgetsToImage(
                              controller: editCV.controllerWidget,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  VideoPlayer(editCV.videoPlayerController),
                                  editCV.isEdit
                                      ? Painter(editCV.controller)
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      editCV.isEdit
                          ? TableListThumbnails(
                              list: editCV.listThumbnail,
                              onChanged: (ThumbnailBD value) {
                                editCV.videoPlayerController.pause();
                                editCV.isSelectThumb = true;
                                editCV.thumbnailSelect = value;
                                editCV.videoPlayerController.seekTo(
                                    Duration(milliseconds: value.timeMs));
                                setState(() {});
                              },
                            )
                          : const SizedBox.shrink(),
                      Container(
                        color: Colors.amber,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listThumb.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 50,
                                  width: 50,
                                  child: listThumb[index]);
                            },
                          ),
                        ),
                      ),
                      editCV.isloading
                          ? const Center(child: LoadingCustom())
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawBar extends StatefulWidget {
  final PainterController _controller;
  late bool _isedit;
  final ValueChanged<bool> onEdit;
  DrawBar(this._controller, this._isedit, this.onEdit, {super.key});

  @override
  State<DrawBar> createState() => _DrawBarState();
}

class _DrawBarState extends State<DrawBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Flexible(child: StatefulBuilder(
        //     builder: (BuildContext context, StateSetter setState) {
        //   return SizedBox(
        //       child: Slider(
        //     value: _controller.thickness,
        //     onChanged: (double value) => setState(() {
        //       _controller.thickness = value;
        //     }),
        //     min: 1.0,
        //     max: 20.0,
        //     activeColor: Colors.white,
        //   ));
        // })),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return RotatedBox(
              quarterTurns: 0,
              child: IconButton(
                color: widget._isedit ? Colors.orangeAccent : Colors.black,
                icon: const Icon(Icons.create),
                tooltip:
                    '${widget._controller.eraseMode ? 'Disable' : 'Enable'} eraser',
                onPressed: () {
                  setState(
                    () {
                      if (widget._isedit) {
                        widget._isedit = false;
                      } else {
                        widget._isedit = true;
                      }
                      widget.onEdit(widget._isedit);
                      widget._controller.eraseMode = false;
                    },
                  );
                },
              ),
            );
          },
        ),
        ColorPickerButton(widget._controller, false),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  const ColorPickerButton(this._controller, this._background, {super.key});
  final PainterController _controller;
  final bool _background;
  @override
  State<ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(_iconData, color: _color),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Pick color'),
                  ),
                  body: Container(
                      alignment: Alignment.center,
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (Color c) => pickerColor = c,
                      )));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.palette;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
