import 'dart:io';
import 'dart:typed_data';

import 'package:Klasspadel/Common/colors_palette.dart';
import 'package:Klasspadel/Models/thumbnail.dart';
import 'package:Klasspadel/Page/Home/Pageview/homeScreen.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/container_list_recoder.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/edit_controll_custom.dart';
import 'package:Klasspadel/WidgetsCustom/filter_user.dart';
import 'package:Klasspadel/WidgetsCustom/user_custom_select.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class TestPages extends StatefulWidget {
  const TestPages(
      {super.key,
      required this.videoPlayerController,
      required this.listThumb});
  final VideoPlayerController videoPlayerController;
  final List<Thumbnail> listThumb;
  @override
  State<TestPages> createState() => _TestPagesState();
}

class _TestPagesState extends State<TestPages> {
  final _formKey = GlobalKey<FormState>();
  bool isplay = true;
  int selectThum = -1;
  String _handPreference = 'Alumnos';
  bool selectUser = false;
  List<Image> listThumb = [];
  List<Widget> listThumbW = [];
  @override
  void initState() {
    super.initState();
    // showList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showList() async {
    var a = widget.videoPlayerController.dataSource.toString();
    print(a);
    listThumb = await generateThumbnails(a.toString());
    setState(() {});
  }

  Future<List<Image>> generateThumbnails(String videoUrl) async {
    final List<Image> thumbnails = [];
    final List<Widget> thumbnailsW_temp = [];
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
// thumbnailsW_temp.add(value)
    return thumbnails;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview video'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.publish,
            ),
            tooltip: 'save',
            onPressed: () async {
              showModalBottomSheet(
                  elevation: 1,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) => SingleChildScrollView(
                        child: Container(
                          color: Colors.transparent,
                          height: 600,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 47, 45, 45),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Publica tu video',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Column(children: [
                                  // TextFormField(
                                  //   onChanged: (String value) {
                                  //     // title = value;
                                  //   },
                                  //   decoration: const InputDecoration(
                                  //     labelText: 'Título',
                                  //     border: OutlineInputBorder(),
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 16),
                                  // TextFormField(
                                  //   onChanged: (String value) {
                                  //     // descripVideo = value;
                                  //   },
                                  //   decoration: const InputDecoration(
                                  //     labelText: 'Descripción',
                                  //     border: OutlineInputBorder(),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 16),
                                  SelectPlayerWidget(),
                                  // DropdownButtonFormField<String>(
                                  //   value: _handPreference,
                                  //   onChanged: (value) => setState(
                                  //       () => _handPreference = value!),
                                  //   items: [
                                  //     'Alumnos',
                                  //     'Carlos',
                                  //     'Javier',
                                  //     'Otros mas'
                                  //   ].map((value) {
                                  //     return DropdownMenuItem<String>(
                                  //       value: value,
                                  //       child: Text(value),
                                  //     );
                                  //   }).toList(),
                                  //   decoration: const InputDecoration(
                                  //       labelText: 'Seleccionar alumno'),
                                  // ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  ColorPalette.principal),
                                          elevation:
                                              MaterialStateProperty.all<double>(
                                                  0),
                                          overlayColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (selectUser) {
                                            widget.listThumb;
                                            _handPreference;
                                          } else {}
                                        },
                                        child: const Text('Guardar'),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  ColorPalette.principal),
                                          elevation:
                                              MaterialStateProperty.all<double>(
                                                  0),
                                          overlayColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              VideoPlayer(widget.videoPlayerController),
              // Positioned(
              //   bottom: 10,
              //   child: SizedBox(
              //     height: 100,
              //     width: size.width,
              //     child: Padding(
              //       padding: const EdgeInsets.all(4.0),
              //       child: Container(
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: const Alignment(0, 1),
              //             colors: <Color>[
              //               const Color.fromRGBO(255, 154, 0, 0.88)
              //                   .withAlpha(70),
              //               const Color.fromARGB(255, 230, 48, 48)
              //                   .withAlpha(70),
              //             ],
              //             tileMode: TileMode.mirror,
              //           ),
              //           border: Border.all(
              //               color: const Color.fromRGBO(219, 177, 42, 1)),
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(20)),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: ListView.separated(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: listThumb.length,
              //             itemBuilder: (context, index) {
              //               Image? tempImg;
              //               if (widget.listThumb.isNotEmpty) {
              //                 if ((index) <= (widget.listThumb.length - 1)) {
              //                   var temp = widget.listThumb[index];
              //                   tempImg = Image.memory(
              //                     temp.imageUrl!,
              //                     height: size.height,
              //                     width: size.width,
              //                     scale: 1,
              //                     fit: BoxFit.fill,
              //                   );
              //                 }
              //               }

              //               return Container(
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color:
              //                           const Color.fromRGBO(219, 177, 42, 1)),
              //                   borderRadius:
              //                       const BorderRadius.all(Radius.circular(10)),
              //                   color: Colors.white.withAlpha(80),
              //                   // image: DecorationImage(
              //                   //   image: listThumb[index].image,
              //                   //   fit: BoxFit.cover,
              //                   // ),
              //                 ),
              //                 height: 50,
              //                 width: 80,
              //                 child: Stack(
              //                   children: [
              //                     listThumb[index],
              //                     tempImg != null
              //                         ? Container(
              //                             decoration: BoxDecoration(
              //                               border: Border.all(
              //                                   color: const Color.fromRGBO(
              //                                       219, 177, 42, 1)),
              //                               borderRadius:
              //                                   const BorderRadius.all(
              //                                       Radius.circular(10)),
              //                               color: Colors.white.withAlpha(80),
              //                               image: DecorationImage(
              //                                 image: tempImg!.image,
              //                                 fit: BoxFit.cover,
              //                               ),
              //                             ),
              //                           )
              //                         : const SizedBox.shrink(),
              //                   ],
              //                 ),
              //               );
              //             },
              //             separatorBuilder: (BuildContext context, int index) {
              //               return Container(
              //                 width: 8,
              //                 color: Colors.transparent,
              //               );
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              isplay && widget.listThumb.length != 0 && selectThum != -1
                  ? (widget.listThumb[selectThum].imageUrl != Uint8List(0))
                      ? Image.memory(
                          widget.listThumb[selectThum].imageUrl!,
                          height: size.height,
                          width: size.width,
                          scale: 1,
                          fit: BoxFit.fill,
                        )
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 800,
                      child: ContainerListRecoder(
                        listThumbnail: widget.listThumb,
                        onDelete: (int value) {
                          // listRecoded.removeAt(value);
                        },
                        onShowThumb: (int value) {
                          selectThum = value;
                          setState(() {});
                        },
                        onClose: (bool value) {},
                      ),
                    ),
                  );
                }),
              ),
              // EditControllCustom(
              //   nameAudio: '',
              //   listThumb: [],
              //   onChanged: (Thumbnail value) {},
              //   onDelete: (int value) {},
              //   onShowThumb: (int value) {},
              //   onSavePublish: (bool value) {},
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void selectPlayer(contact) {
    _handPreference = contact;
    selectUser = true;
    setState(
      () {},
    );
  }
}

class PadelScoreWidget extends StatefulWidget {
  const PadelScoreWidget({super.key, required this.isSelectPlayer});
  final bool isSelectPlayer;
  @override
  State<PadelScoreWidget> createState() => _PadelScoreWidgetState();
}

class _PadelScoreWidgetState extends State<PadelScoreWidget> {
  List<PadelStroke> strokes = []; // Lista de golpes y puntuaciones
  String selectedStroke = "Drive"; // Golpe seleccionado
  double score = 0;

  // Lista de diferentes golpes de pádel
  final List<String> availableStrokes = [
    "Drive",
    "Volea",
    "Remate",
    "Bandeja",
    "Saque",
    "Smash",
    "Drop shot",
  ];

  void addStroke() {
    if (score > 0) {
      PadelStroke newStroke = PadelStroke(selectedStroke, score);
      setState(() {
        strokes.add(newStroke);
        selectedStroke = "Drive"; // Restablece el golpe seleccionado
        score = 0; // Restablece la puntuación
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isSelectPlayer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Golpe: $selectedStroke',
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
              PopupMenuButton(
                initialValue: selectedStroke,
                onSelected: (String value) {
                  setState(() {
                    selectedStroke = value;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return availableStrokes.map((String stroke) {
                    return PopupMenuItem(
                      value: stroke,
                      child: Text(stroke),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.black.withAlpha(30),
            ),
            width: 175,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Nivel:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.white),
                      onPressed: () {
                        if (score > 0) {
                          setState(() {
                            score -= 0.5;
                          });
                        }
                      },
                    ),
                    Text(
                      '$score',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        if (score < 7) {
                          setState(() {
                            score += 0.5;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorPalette.principal),
              elevation: MaterialStateProperty.all<double>(0),
              overlayColor: MaterialStateProperty.all<Color>(
                Colors.transparent,
              ),
            ),
            onPressed: addStroke,
            child: const Text("Agregar Golpe"),
          ),
          const SizedBox(
            height: 10,
          ),
          if (strokes.isNotEmpty)
            const Text(
              'Historial de Golpes:',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          const SizedBox(
            height: 10,
          ),
          for (var stroke in strokes)
            Text(
              '${stroke.stroke}: ${stroke.score}',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
        ],
      ),
    );
  }
}

class PadelStroke {
  final String stroke;
  final double score;

  PadelStroke(this.stroke, this.score);
}

class SelectPlayerWidget extends StatefulWidget {
  const SelectPlayerWidget({super.key});

  @override
  State<SelectPlayerWidget> createState() => _SelectPlayerWidgetState();
}

class _SelectPlayerWidgetState extends State<SelectPlayerWidget> {
  String _handPreference = 'Alumnos';
  bool selectUser = false;
  void selectPlayer(contact) {
    _handPreference = contact;
    selectUser = true;
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorPalette.principal),
            elevation: MaterialStateProperty.all<double>(0),
            overlayColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
          ),
          onPressed: () async {
            var a = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilterContactListScreen(
                  oncontactSelected: selectPlayer,
                ),
              ),
            );
          },
          child: const Text('Seleccionar jugador'),
        ),
        Visibility(
          visible: selectUser,
          child: UserCustomSelect(
            isFilter: false,
            name: _handPreference,
            onDelete: (bool value) {
              selectUser = false;
              setState(() {});
            },
          ),
        ),
        PadelScoreWidget(
          isSelectPlayer: selectUser,
        ),
      ],
    );
  }
}

// Duration elapsedTimeTemp = Duration(
//     seconds: widget.thumbnails.timeMs);

// var elapsedTimeString =
//     "${elapsedTimeTemp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(elapsedTimeTemp.inSeconds.remainder(60)).toString().padLeft(2, '0')}";

// var save = await GallerySaver.saveVideo(
//     widget.filePath);
// var video = VideoBD(
//     urlVideo: widget.filePath,
//     title: title,
//     descriptionVideo: descripVideo,
//     name: alumno,
//     imgage: widget.thumbnails.imageUrl,
//     time: elapsedTimeString,
//     listThumbnail: [],
//     timeRecoded: DateTime.now(),
//     listRecoded: []);

// var req = await saveCV.saveVideo(video);

// if (save! && req) {
//   // ignore: use_build_context_synchronously
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//         builder: (context) =>
//             const HomePage(
//               typeUser: "1",
//             )),
//   );
// }
