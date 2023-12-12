import 'dart:io';

import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/WidgetsCustom/barPlayer.dart';
import 'package:Klasspadel/WidgetsCustom/loading_custom.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {super.key,
      required this.item,
      required this.onChangedThum,
      required this.onChangedTimeThumbnail});
  final VideoBD item;
  final ValueChanged<ThumbnailBD> onChangedThum;
  final ValueChanged<int> onChangedTimeThumbnail;
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  late Stream<double> _videoPositionStream;
  bool isloading = false;
  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.item.urlVideo));

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, state) {
              if (state.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingCustom());
              } else {
                return Stack(children: [
                  AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController)),
                  BarPlayer(
                    videoPlayerController: _videoPlayerController,
                    videoPositionStream: _videoPositionStream,
                    thumbnails: const [],
                    onChangedThum: (ThumbnailBD value) {
                      widget.onChangedThum(value);
                    },
                    onChangedTimeThumbnail: (int value) {
                      widget.onChangedTimeThumbnail(value);
                    },
                  ),
                ]);
              }
            },
          ),
        ],
      ),
    );
  }
}
