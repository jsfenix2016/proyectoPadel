import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Models/thumbnail.dart';
import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/test_pages.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/edit_button_expand.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/edit_controll_custom.dart';
import 'package:Klasspadel/WidgetsCustom/barPlayer.dart';
import 'package:Klasspadel/WidgetsCustom/loading_custom.dart';
import 'package:Klasspadel/WidgetsCustom/tableListThumbnails.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class VideoEditPlayerScreen extends StatefulWidget {
  const VideoEditPlayerScreen({super.key, required this.item});
  final VideoBD item;

  @override
  State<VideoEditPlayerScreen> createState() => _VideoEditPlayerScreenState();
}

class _VideoEditPlayerScreenState extends State<VideoEditPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  late Stream<double> videoPositionStream;
  WidgetsToImageController controller = WidgetsToImageController();

  List<Widget> thumbnailsTemp = [];
  late VideoBD itemTemp;
  double aspectRatio = 9 / 16;
  bool isVisibily = true;
  int selectIndexThum = -1;

  @override
  void initState() {
    itemTemp = widget.item;
    _videoPlayerController =
        VideoPlayerController.file(File(widget.item.urlVideo));

    initializeVideoPlayerFuture = _videoPlayerController.initialize();
    videoPositionStream =
        Stream<double>.periodic(const Duration(milliseconds: 200), (_) {
      return _videoPlayerController.value.position.inMilliseconds.toDouble();
    }).takeWhile((position) {
      return _videoPlayerController.value.isPlaying &&
          position <=
              _videoPlayerController.value.duration.inMilliseconds.toDouble();
    });

    _videoPlayerController.pause();
    // generateThumbnails(File(widget.item.urlVideo).path);
    super.initState();
  }

  // processVideoThumbnail(SendPort senPort) async {
  //   final bytes = await controller.capture();

  //   // senPort.send();
  // }

  // Future<List<Widget>> generateThumbnails(String videoUrl) async {
  //   final List<Widget> thumbnails = [];
  //   int thumbnailCount = 10; // Número de miniaturas que deseas generar

  //   for (int i = 0; i < thumbnailCount; i++) {
  //     final uint8list = await VideoThumbnail.thumbnailData(
  //       video: videoUrl,
  //       imageFormat: ImageFormat.JPEG,
  //       maxWidth: 150,
  //       quality: 100,
  //       timeMs: (i * 1000), // Obtener miniaturas en intervalos de 1 segundo
  //     );

  //     if (uint8list!.isNotEmpty) {
  //       final image = Image.memory(
  //         uint8list,
  //         fit: BoxFit.cover,
  //       );
  //       thumbnails.add(image);
  //     }
  //   }
  //   thumbnailsTemp = thumbnails;
  //   setState(() {});
  //   return thumbnailsTemp;
  // }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Pantalla de Video'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: initializeVideoPlayerFuture,
              builder: (context, state) {
                if (state.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingCustom());
                } else {
                  return Container(
                    color: Colors.white,
                    width: size.width,
                    child: VideoEditPlayerWidget(
                      thumbnailSelect: (selectIndexThum != -1)
                          ? widget.item.listThumbnail[selectIndexThum]
                          : null,
                      listThumbnail: widget.item.listThumbnail,
                      videoPlayerController: _videoPlayerController,
                      onChangedExpand: (bool value) {
                        if (value) {
                          aspectRatio = 0.545;
                          isVisibily = false;
                        } else {
                          aspectRatio = 19 / 12;
                          isVisibily = true;
                        }

                        setState(() {});
                      },
                      videoPositionStream: videoPositionStream,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// child: Column(
//   mainAxisSize: MainAxisSize.min,
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   children: [

// Expanded(
//   flex: 0,
//   child: FutureBuilder(
//     future: initializeVideoPlayerFuture,
//     builder: (context, state) {
//       if (state.connectionState == ConnectionState.waiting) {
//         return const Center(child: LoadingCustom());
//       } else {
//         return Container(
//           color: Colors.amber,
//           height: 100,
//           width: size.width,
//           child: AspectRatio(
//             aspectRatio:
//                 aspectRatio, // Relación de aspecto del video
//             child: VideoEditPlayerWidget(
//               thumbnailSelect: (selectIndexThum != -1)
//                   ? widget.item.listThumbnail[selectIndexThum]
//                   : null,
//               listThumbnail: widget.item.listThumbnail,
//               videoPlayerController: _videoPlayerController,
//               onChangedExpand: (bool value) {
//                 if (value) {
//                   aspectRatio = 0.545;
//                   isVisibily = false;
//                 } else {
//                   aspectRatio = 19 / 12;
//                   isVisibily = true;
//                 }

//                 setState(() {});
//               },
//               videoPositionStream: videoPositionStream,
//             ), // Reemplaza esto con tu widget de reproducción de video
//           ),
//         );
//       }
//     },
//   ),
// ),
// Visibility(
//   visible: true,
//   child: Padding(
//     padding: const EdgeInsets.only(top: 8.0, bottom: 0.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // const SizedBox(height: 16),
//         Container(
//           color: Colors.amber,
//           height: 100, // Altura fija de la lista de imágenes
//           child: ListView.separated(
//             separatorBuilder: (context, index) {
//               return const SizedBox(
//                 width: 5,
//               );
//             },
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.item.listThumbnail.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   var tempSelect = widget.item.listThumbnail[index];
//                   tempSelect.imageUrl;
//                   selectIndexThum = index;

//                   setState(() {
//                     _videoPlayerController.seekTo(
//                         Duration(milliseconds: tempSelect.timeMs));
//                     _videoPlayerController.pause();
//                   });
//                 },
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Image.memory(
//                     widget.item.listThumbnail[index].imageUrl,
//                     height: 120,
//                     width: 120,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Container(
//           width: size.width,
//           height: 100,
//           color: Colors.red,
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemCount: thumbnailsTemp.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   color: Colors.amber,
//                   width: 100,
//                   height: 100,
//                   child: thumbnailsTemp[index],
//                 ),
//               );
//             },
//           ),
//         ),

//         // Container(
//         //   color: Colors.red,
//         //   child: PageView.builder(
//         //     itemCount: widget.item.listThumbnail.length,
//         //     itemBuilder: (context, index) {
//         //       return Column(
//         //         mainAxisSize: MainAxisSize.min,
//         //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         //         children: [
//         //           Text(
//         //             widget
//         //                 .item
//         //                 .listThumbnail[selectIndexThum != -1
//         //                     ? selectIndexThum
//         //                     : index]
//         //                 .titleThumb,
//         //             style: const TextStyle(
//         //                 fontSize: 24, fontWeight: FontWeight.bold),
//         //           ),
//         //           const SizedBox(height: 8),
//         //           Text(widget
//         //               .item
//         //               .listThumbnail[selectIndexThum != -1
//         //                   ? selectIndexThum
//         //                   : index]
//         //               .descriptionThumb),
//         //         ],
//         //       );
//         //     },
//         //   ),
//         // ),
//       ],
//     ),
//   ),
// ),
// ],

class VideoEditPlayerWidget extends StatefulWidget {
  VideoEditPlayerWidget(
      {super.key,
      required this.videoPlayerController,
      required this.onChangedExpand,
      required this.listThumbnail,
      this.thumbnailSelect,
      required this.videoPositionStream});
  final VideoPlayerController videoPlayerController;
  late Stream<double> videoPositionStream;
  final ValueChanged<bool> onChangedExpand;
  final List<ThumbnailBD> listThumbnail;
  final ThumbnailBD? thumbnailSelect;

  @override
  State<VideoEditPlayerWidget> createState() => _VideoEditPlayerWidgetState();
}

class _VideoEditPlayerWidgetState extends State<VideoEditPlayerWidget> {
  bool isExpand = false;
  late ThumbnailBD thumSelect;
  late ThumbnailBD thumSelectTemp;
  Uint8List thum = Uint8List(0);
  Uint8List? bytesRecoder = Uint8List(0);
  bool isplay = false;
  final List<Thumbnail> listThumb = [];
  List<ThumbnailBD> listThumbBD = [];
  int nameaudio = 0;
  int selectThum = -1;
  @override
  void initState() {
    initThumbnails();

    super.initState();
  }

  void initThumbnails() {
    thumSelectTemp = thumSelect = ThumbnailBD(
        timeMs: 0,
        imageUrl: thum,
        descriptionThumb: "",
        titleThumb: "",
        timeCapture: DateTime.now(),
        recoderUrl: bytesRecoder!,
        recoderPath: '',
        timeDurationRecoded: '',
        titleRecoded: '');

    if (widget.thumbnailSelect != null) {
      thumSelect = widget.thumbnailSelect!;
    }
  }

  // List<Widget> _trimSlider() {
  //   return [
  // AnimatedBuilder(
  //   animation: Listenable.merge([
  //     widget.videoPlayerController,
  //   ]),
  //   builder: (_, __) {
  //     final int duration =
  //         widget.videoPlayerController.value.duration.inSeconds;
  //     final double pos =
  //         widget.videoPlayerController.value.duration.inSeconds.toDouble() *
  //             duration;

  //     return Padding(
  //       padding: EdgeInsets.symmetric(
  //           horizontal: MediaQuery.of(context).size.height / 4),
  //       child: const Row(children: [
  //         // Text(formatter(Duration(seconds: pos.toInt()))),
  //         Expanded(child: SizedBox()),
  //         AnimatedOpacity(
  //           opacity: 0,
  //           duration: kThemeAnimationDuration,
  //           child: Row(mainAxisSize: MainAxisSize.min, children: [
  //             // Text(formatter(widget.videoPlayerController.startTrim)),
  //             // const SizedBox(width: 10),
  //             // Text(formatter(widget.videoPlayerController.)),
  //           ]),
  //         ),
  //       ]),
  //     );
  //   },
  // ),
  // Container(
  //   width: MediaQuery.of(context).size.width,
  //   margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 4),
  //   child: TrimSlider(
  //     controller: _controller,
  //     height: MediaQuery.of(context).size.height,
  //     horizontalMargin: MediaQuery.of(context).size.height / 4,
  //     child: TrimTimeline(
  //       controller: _controller,
  //       padding: const EdgeInsets.only(top: 10),
  //     ),
  //   ),
  // )
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    // Implementa aquí tu widget de reproducción de video
    final size = MediaQuery.of(context).size;
    if (widget.thumbnailSelect != null && isExpand == false) {
      var temp = widget.thumbnailSelect!;
      thumSelect = temp;

      if (thumSelect.imageUrl == thum) {
        print('Las listas son iguales');
      } else {
        print('Las listas son diferentes');
      }
    }

    return Container(
      color: Colors.black,
      child: Center(
        child: Stack(
          children: [
            VideoPlayer(widget.videoPlayerController),
            // isplay && listThumb.length != 0 && selectThum != -1
            //     ? (listThumb[selectThum].imageUrl != Uint8List(0))
            //         ? Image.memory(
            //             listThumb[selectThum].imageUrl!,
            //             height: size.height,
            //             width: size.width,
            //             scale: 1,
            //             fit: BoxFit.fill,
            //           )
            //         : const SizedBox.shrink()
            //     : const SizedBox.shrink(),
            (listThumb.isNotEmpty && selectThum != -1)
                ? Visibility(
                    visible: true,
                    child: Image.memory(
                      listThumb[selectThum].imageUrl!,
                      height: size.height,
                      width: size.width,
                      scale: 1,
                      fit: BoxFit.fill,
                    ))
                : const SizedBox.shrink(),
            EditControllCustom(
              nameAudio: nameaudio.toString(),
              listThumb: listThumb,
              onChanged: addThumbnailNew,
              onDelete: (int value) {
                listThumb.removeAt(value);
                setState(() {});
              },
              onShowThumb: showThumbnailSelect,
              onSavePublish: (bool value) {
                Future.sync(
                  () async => {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestPages(
                          videoPlayerController: widget.videoPlayerController,
                          listThumb: listThumb,
                        ),
                      ),
                    ),
                  },
                );
                //              var elapsedTimeString =
                //     "${elapsedTimeTemp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(elapsedTimeTemp.inSeconds.remainder(60)).toString().padLeft(2, '0')}";

                // var save = await GallerySaver.saveVideo(widget.filePath);
                // var video = VideoBD(
                //     urlVideo: widget.filePath,
                //     title: 'title',
                //     descriptionVideo: descripVideo,
                //     name: alumno,
                //     imgage: widget.thumbnails.imageUrl,
                //     time: elapsedTimeString,
                //     listThumbnail: [],
                //     timeRecoded: DateTime.now(),
                //     listRecoded: []);

                // var req = await saveCV.saveVideo(video);
              },
            ),

            // // Creating a icon button
            // IconButton(
            //   iconSize: 40,
            //   icon: const Icon(
            //     Icons.expand,
            //   ),
            //   // the method which is called
            //   // when button is pressed
            //   onPressed: () {
            //     if (isExpand == false) {
            //       isExpand = true;
            //     } else {
            //       isExpand = false;
            //     }
            //     widget.onChangedExpand(isExpand);
            //   },
            // ),
            // isExpand
            //     ?
            // TableListThumbnails(
            //   list: widget.listThumbnail,
            //   onChanged: (ThumbnailBD value) {
            //     widget.videoPlayerController.pause();
            //     thumSelect = value;
            //     widget.videoPlayerController
            //         .seekTo(Duration(milliseconds: value.timeMs));
            //     (context as Element).markNeedsBuild();
            //   },
            // ),
            // : const SizedBox.shrink(),

            // isExpand
            //     ? ThumbnailWidget(
            //         thumbnail: thumSelect,
            //       )
            //     : const SizedBox.shrink(),

            Positioned(
              bottom: 10,
              left: 5,
              child: BarPlayer(
                videoPlayerController: widget.videoPlayerController,
                videoPositionStream: widget.videoPositionStream,
                thumbnails: widget.listThumbnail,
                onChangedThum: (ThumbnailBD value) {
                  widget.videoPlayerController.pause();
                  isplay = false;
                },
                onChangedTimeThumbnail: (int value) async {
                  print(value);

                  if (widget.videoPlayerController.value.isPlaying == false) {
                    // isplay = true;
                    // Uint8List uint8list =
                    //     await loadImage('assets/images/imageDraw.png');
                    // thumSelect.imageUrl = uint8list;
                    // selectThum = -1;
                    // widget.videoPlayerController.play();
                    (context as Element).markNeedsBuild();
                  } else {
                    isplay = false;
                    selectThum = -1;
                    (context as Element).markNeedsBuild();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showThumbnailSelect(int value) {
    Thumbnail thumbnailTemp = Thumbnail(
        timeMs: 0.toString(),
        imageUrl: Uint8List(0),
        descriptionThumb: "",
        titleThumb: "",
        timeCapture: DateTime.now().toIso8601String(),
        pathRecoded: '',
        timeDurationRecoded: '',
        titleRecoded: '');
    thumbnailTemp = listThumb[value];
    thumSelect.imageUrl = listThumb[value].imageUrl!;
    isplay = false;
    selectThum = value;
    widget.videoPlayerController
        .seekTo(Duration(milliseconds: int.parse(listThumb[value].timeMs)));
    (context as Element).markNeedsBuild();
  }

  void addThumbnailNew(Thumbnail value) {
    // ThumbnailBD thumbTemp = ThumbnailBD(
    //     timeMs: 0,
    //     imageUrl: thum,
    //     descriptionThumb: "",
    //     titleThumb: "",
    //     timeCapture: DateTime.now(),
    //     recoderUrl: bytesRecoder!,
    //     recoderPath: '',
    //     timeDurationRecoded: '',
    //     titleRecoded: '');

    Thumbnail newthumb = Thumbnail(
        timeMs: '0',
        imageUrl: thum,
        descriptionThumb: "",
        titleThumb: "",
        timeCapture: DateTime.now().toString(),
        pathRecoded: '',
        timeDurationRecoded: '',
        titleRecoded: '');

    var temp = Duration(
        milliseconds:
            widget.videoPlayerController.value.position.inMilliseconds);

    // thumbTemp.recoderPath = value.pathRecoded;
    // thumbTemp.timeMs = temp.inMilliseconds;
    // thumbTemp.imageUrl = value.imageUrl!;
    // thumbTemp.titleRecoded = value.titleRecoded;
    // thumbTemp.timeDurationRecoded = value.timeDurationRecoded;
    // listThumbBD.add(thumbTemp);

    newthumb.timeMs = temp.inMilliseconds.toString();
    newthumb.pathRecoded = value.pathRecoded;
    newthumb.timeMs = temp.inMilliseconds.toString();
    newthumb.imageUrl = value.imageUrl!;
    newthumb.titleRecoded = value.titleRecoded;
    newthumb.timeDurationRecoded = value.timeDurationRecoded;
    listThumb.insert(nameaudio, newthumb);
    nameaudio++;
    // setState(() {});
  }
}

class ThumbnailWidget extends StatefulWidget {
  final ThumbnailBD thumbnail;

  const ThumbnailWidget({super.key, required this.thumbnail});

  @override
  State<ThumbnailWidget> createState() => _ThumbnailWidgetState();
}

class _ThumbnailWidgetState extends State<ThumbnailWidget> {
  ScrollController scrollController = ScrollController();
  double _scrollPosition = 0.0;
  double _xPosition = -350 + 40;
  double _yPosition = 430;
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double widgetHeight = screenHeight / 3;

    return Positioned(
      bottom: 70,
      left: _xPosition,
      // top: _yPosition,
      child: GestureDetector(
        onPanUpdate: (dragUpdate) {
          setState(() {
            _xPosition += dragUpdate.delta.dx;
          });
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: Colors.white,
          ),
          height: 200,
          width: 340,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.thumbnail.titleThumb,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.thumbnail.descriptionThumb,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
