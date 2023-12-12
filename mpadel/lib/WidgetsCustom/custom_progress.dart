import 'package:Klasspadel/Models/thumbnailbd.dart';

import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:video_player/video_player.dart';

class CustomProgressBar extends StatefulWidget {
  const CustomProgressBar(
      {super.key,
      required this.videoPlayerController,
      required this.thumbnails,
      required this.onChanged,
      required this.onChangedThumbnail});
  final VideoPlayerController videoPlayerController;
  final List<ThumbnailBD> thumbnails;
  final ValueChanged<ThumbnailBD> onChanged;
  final ValueChanged<int> onChangedThumbnail;
  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  late double _currentSliderValue;
  late double _sliderValueMax;

  @override
  void initState() {
    super.initState();
    widget.videoPlayerController.pause();
    _sliderValueMax =
        widget.videoPlayerController.value.duration.inMilliseconds.toDouble();
    _currentSliderValue =
        widget.videoPlayerController.value.position.inMilliseconds.toDouble();
    widget.videoPlayerController.addListener(() {
      setState(() {
        _currentSliderValue = widget
            .videoPlayerController.value.position.inMilliseconds
            .toDouble();
        NotificationCenter().notify(
          'myNotification',
          data: widget.videoPlayerController.value.position.inMilliseconds
              .toInt(),
        );
        _sliderValueMax = widget
            .videoPlayerController.value.duration.inMilliseconds
            .toDouble();
        widget.onChangedThumbnail(
            widget.videoPlayerController.value.position.inMilliseconds.toInt());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          trackHeight: 20,
          thumbColor: Colors.orangeAccent,
          activeTrackColor: Colors.white.withAlpha(100),
          inactiveTrackColor: Colors.blueGrey.withAlpha(100),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10)),
      child: Slider(
        min: 0.0,
        max: _sliderValueMax,
        value: _currentSliderValue,
        onChanged: (value) {
          setState(() {
            _currentSliderValue = value;
          });
          widget.videoPlayerController
              .seekTo(Duration(milliseconds: value.toInt()));
          widget.onChangedThumbnail(_currentSliderValue.toInt());
        },
      ),
    );
  }
}
