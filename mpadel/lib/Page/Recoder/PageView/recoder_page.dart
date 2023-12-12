import 'dart:async';
import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/Loading/loading_screen.dart';
import 'package:Klasspadel/Page/SaveVideo/saveVideo.dart';
import 'package:Klasspadel/Page/video_edit_player.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/recoded_count.dart';
import 'package:Klasspadel/WidgetsCustom/loading_custom.dart';
import 'package:Klasspadel/WidgetsCustom/user_custom_select.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:Klasspadel/Page/Video/Pageview/previewVideoPage.dart';
import 'package:flutter/services.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class RecoderVideoPage extends StatefulWidget {
  const RecoderVideoPage({Key? key}) : super(key: key);

  @override
  State<RecoderVideoPage> createState() => _RecoderPageState();
}

class _RecoderPageState extends State<RecoderVideoPage> {
  WidgetsToImageController controller = WidgetsToImageController();
  late CameraController _cameraController;
  Uint8List? bytesRecoder = Uint8List(0);
  bool _isLoading = true;
  bool _isRecording = false;

  int _elapsedTime = 0;
  late Timer _timer;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((_) {
      // Iniciar la grabación de video
    });
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final front = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);
      _cameraController = CameraController(front, ResolutionPreset.medium);
      await _cameraController.initialize();
    }

    setState(() => _isLoading = false);
  }

  void goToPreview(String path) async {
    var confirmExit = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Información'),
        content: const Text('Desea guardar o editar el video?'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.edit,
              ),
              tooltip: 'Negar',
              onPressed: () async {
                // Navigator.of(context).pop(false);
                Navigator.pop(context, false);
              }),
          IconButton(
              icon: const Icon(
                Icons.save,
              ),
              tooltip: 'Aceptar',
              onPressed: () async {
                // Navigator.of(context).pop(true);

                Navigator.pop(context, true);
              }),
        ],
      ),
    );

    if (confirmExit) {
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => PreviewVideoPage(filePath: path)),
      // );
      setState(() => _isLoading = true);

      var bytes = await controller.capture();

      ThumbnailBD thumbnails = ThumbnailBD(
          timeMs: 0,
          imageUrl: bytes!,
          descriptionThumb: "",
          titleThumb: "",
          timeCapture: DateTime.now(),
          recoderUrl: bytesRecoder!,
          recoderPath: '',
          timeDurationRecoded: '',
          titleRecoded: '');
      Future.sync(
        () async => {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SaveVideoPage(thumbnails: thumbnails, filePath: path),
            ),
          ),
        },
      );
      setState(() => _isLoading = false);
    } else {
      setState(() => _isLoading = true);
      // var bytes = await controller.capture();
      VideoBD video = VideoBD(
          urlVideo: path,
          title: 'nuevo video',
          descriptionVideo: "",
          imgage: Uint8List(0),
          name: "",
          time: _timer.tick.toString(),
          listThumbnail: [],
          timeRecoded: DateTime.now(),
          listRecoded: []);
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoEditPlayerScreen(item: video)),
      );
      setState(() => _isLoading = false);
    }
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      stopRecording();
      goToPreview(file.path);
    } else {
      await Future.wait([
        _cameraController.prepareForVideoRecording(),
        _cameraController.startVideoRecording()
      ]);

      _elapsedTime = 0;
      startRecording();
      setState(() => _isRecording = true);
    }
  }

  void startRecording() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  void stopRecording() {
    // Detener la grabación de video y detener el timer
    _timer.cancel();
    // _elapsedTime = 0;
  }

  @override
  Widget build(BuildContext context) {
    Duration elapsedTimeTemp = Duration(seconds: _elapsedTime);

    String elapsedTimeString =
        "${elapsedTimeTemp.inHours.remainder(60).toString().padLeft(2, '0')}:${elapsedTimeTemp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(elapsedTimeTemp.inSeconds.remainder(60)).toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Grabar Video'),
      ),
      body: LoadingIndicator(
        isLoading: _isLoading,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              if (!_isLoading)
                WidgetsToImage(
                    controller: controller,
                    child: CameraPreview(_cameraController)),
              Positioned(
                bottom: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      height: 30,
                      width: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(70),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: Text(elapsedTimeString,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                decoration: TextDecoration.none,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    FloatingActionButton(
                      key: const Key("recoderVideo"),
                      backgroundColor: Colors.red,
                      child: Icon(_isRecording ? Icons.stop : Icons.circle),
                      onPressed: () => _recordVideo(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
