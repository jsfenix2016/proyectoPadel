import 'dart:async';
import 'dart:io';

import 'package:Klasspadel/Models/thumbnail.dart';
import 'package:Klasspadel/Models/thumbnailbd.dart';

import 'package:Klasspadel/Page/SaveVideo/saveVideo.dart';
import 'package:Klasspadel/Page/Video/Controller/previewController.dart';
import 'package:Klasspadel/WidgetsCustom/barPlayer.dart';
import 'package:Klasspadel/WidgetsCustom/loading_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

import 'package:widgets_to_image/widgets_to_image.dart';

class PreviewVideoPage extends StatefulWidget {
  final String filePath;

  const PreviewVideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  State<PreviewVideoPage> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideoPage>
    with SingleTickerProviderStateMixin {
  final PreviewController registerService = Get.put(PreviewController());
  late VideoPlayerController _videoPlayerController;
  // late AnimationController _controllerGift;
  WidgetsToImageController controller = WidgetsToImageController();

  String elapsedTimeString = '';

  late Future<void> _initializeVideoPlayerFuture;
  late Stream<double> _videoPositionStream;
  bool _isRecording = false;
  late ThumbnailBD thumbnails;
  bool _isLoading = false;
  Uint8List? bytesRecoder = Uint8List(0);
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));

    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPositionStream =
        Stream<double>.periodic(const Duration(milliseconds: 200), (_) {
      return _videoPlayerController.value.position.inMilliseconds.toDouble();
    }).takeWhile((position) {
      return _videoPlayerController.value.isPlaying &&
          position <=
              _videoPlayerController.value.duration.inMilliseconds.toDouble();
    });

    _videoPlayerController.play();

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // _controllerGift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              setState(() => _isLoading = true);

              _videoPlayerController.pause();
              var bytes = await controller.capture();

              thumbnails = ThumbnailBD(
                  timeMs: _videoPlayerController.value.duration.inSeconds,
                  imageUrl: bytes!,
                  descriptionThumb: "",
                  titleThumb: "",
                  timeCapture: DateTime.now(),
                  recoderUrl: bytesRecoder!,
                  recoderPath: '',
                  timeDurationRecoded: '',
                  titleRecoded: '');
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SaveVideoPage(
                        thumbnails: thumbnails, filePath: widget.filePath)),
              );
              setState(() => _isLoading = false);
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingCustom());
          } else {
            if (_videoPlayerController.value.isInitialized) {
              Duration elapsedTimeTemp = Duration(
                  seconds: _videoPlayerController.value.duration.inSeconds);
              // var a = format.format(Duration(seconds: _elapsedTime));
              elapsedTimeString =
                  "${elapsedTimeTemp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(elapsedTimeTemp.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
            }

            return Center(
              child: Stack(children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: WidgetsToImage(
                    controller: controller,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                ),
                _isLoading ? const LoadingCustom() : const SizedBox.shrink(),
                Positioned(
                  bottom: 1,
                  child: Container(
                    height: 90,
                    width: size.width,
                    color: Colors.transparent.withAlpha(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarPlayer(
                        videoPlayerController: _videoPlayerController,
                        videoPositionStream: _videoPositionStream,
                        thumbnails: [],
                        onChangedThum: (ThumbnailBD value) {
                          _videoPlayerController.pause();
                        },
                        onChangedTimeThumbnail: (int value) {
                          print(value);

                          if (_videoPlayerController.value.isPlaying == false) {
                            // widget.videoPlayerController.play();
                          } else {}
                          (context as Element).markNeedsBuild();
                        },
                      ),
                    ),
                  ),
                ),
              ]),
            );
          }
        },
      ),
    );
  }
}
