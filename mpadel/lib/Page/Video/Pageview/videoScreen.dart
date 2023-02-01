import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';

class VideoImageCapture extends StatefulWidget {
  final String videoUrl;
  final int captureSecond;
  const VideoImageCapture(
      {super.key, required this.videoUrl, required this.captureSecond});
  @override
  _VideoImageCaptureState createState() => _VideoImageCaptureState();
}

class _VideoImageCaptureState extends State<VideoImageCapture> {
  late VideoPlayerController _videoController;
  bool _isPlaying = false;
  bool _isCaptured = false;
  late img.Image _capturedImage;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _playVideo() {
    setState(() {
      _isPlaying = true;
    });
    _videoController.play();
  }

  void _pauseVideo() {
    setState(() {
      _isPlaying = false;
    });
    _videoController.pause();
  }

  void _captureImage() async {
    if (_videoController.value.isInitialized) {
      // Seek to the desired second await _videoController.seekTo(Duration(seconds: widget.captureSecond));
      // Wait for the video to stabilize at the new position await Future.delayed(Duration(milliseconds: 500));
      // Capture the image _capturedImage = await _videoController.getSnapshot();
      // Update the UI to show the captured image setState(() { _isCaptured = true; }); } }
      @override
      Widget build(BuildContext context) {
        return Column(
          children: [
            _isCaptured ? Image.memory(_capturedImage.getBytes()) : Container(),
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isPlaying
                    ? IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: _pauseVideo,
                      )
                    : IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: _playVideo,
                      ),
                // IconButton(
                //   icon: Icon(Icons.camera),
                //   onPressed: _captureImage,
                // ),
              ],
            ),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Demo',
      home: Scaffold(
        body: Column(
          children: [
            _isCaptured ? Image.memory(_capturedImage.getBytes()) : Container(),
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isPlaying
                    ? IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: _pauseVideo,
                      )
                    : IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: _playVideo,
                      ),
                IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: _captureImage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
