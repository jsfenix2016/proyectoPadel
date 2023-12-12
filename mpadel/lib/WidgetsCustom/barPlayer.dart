import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:Klasspadel/WidgetsCustom/custom_progress.dart';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class BarPlayer extends StatefulWidget {
  const BarPlayer(
      {super.key,
      required this.videoPositionStream,
      required this.videoPlayerController,
      required this.thumbnails,
      required this.onChangedThum,
      required this.onChangedTimeThumbnail});
  final Stream<double> videoPositionStream;
  final List<ThumbnailBD> thumbnails;
  final VideoPlayerController videoPlayerController;
  final ValueChanged<ThumbnailBD> onChangedThum;
  final ValueChanged<int> onChangedTimeThumbnail;
  @override
  State<BarPlayer> createState() => _BarPlayerState();
}

class _BarPlayerState extends State<BarPlayer> {
  bool isRecording = true;
  late ThumbnailBD tempThumbnails;
  _recordVideo() async {
    if (isRecording) {
      await widget.videoPlayerController.pause();
      setState(() => isRecording = false);
    } else {
      await widget.videoPlayerController.play();
      setState(() => isRecording = true);
    }
  }

  Future<void> returnTime(Duration time) async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.black.withAlpha(30),
      ),
      height: 45,
      width: size.width - 10,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder<double>(
                stream: widget.videoPositionStream,
                builder: (context, snapshot) {
                  var temp = Duration(
                      milliseconds: widget
                          .videoPlayerController.value.position.inMilliseconds);
                  widget.videoPlayerController.value.isPlaying
                      ? (isRecording = true)
                      : (isRecording = false);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 40,
                          height: 40,
                          color: Colors.grey.withAlpha(100),
                          child: IconButton(
                              icon: Icon(
                                  color: Colors.white,
                                  isRecording ? Icons.stop : Icons.play_arrow),
                              tooltip: 'recordedo',
                              onPressed: () => _recordVideo()),
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "${temp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(temp.inSeconds).toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                        child: CustomProgressBar(
                          thumbnails: widget.thumbnails,
                          videoPlayerController: widget.videoPlayerController,
                          onChanged: (ThumbnailBD value) {
                            tempThumbnails = value;
                            widget.onChangedThum(value);
                            setState(() {});
                          },
                          onChangedThumbnail: (int value) {
                            widget.onChangedTimeThumbnail(value);

                            setState(() {});
                          },
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "${widget.videoPlayerController.value.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(widget.videoPlayerController.value.duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
