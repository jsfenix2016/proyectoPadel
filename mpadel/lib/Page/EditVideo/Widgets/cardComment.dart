import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Common/decoder_custom.dart';
import 'package:Klasspadel/Models/thumbnail.dart';
import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/EditVideo/Controller/editVideoController.dart';
import 'package:Klasspadel/Page/Home/Pageview/homeScreen.dart';
import 'package:Klasspadel/Page/SaveVideo/saveController.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';

class CardCommentWidget extends StatefulWidget {
  const CardCommentWidget(
      {super.key, required this.thumbnails, required this.filePath});

  final ThumbnailBD thumbnails;
  final String filePath;
  @override
  State<CardCommentWidget> createState() => _CardCommentWidgetState();
}

class _CardCommentWidgetState extends State<CardCommentWidget> {
  final EditVideoController saveCV = Get.put(EditVideoController());
  final _formKey = GlobalKey<FormState>();
  late double _currentSliderValue;
  String _handPreference = 'Alumnos';
  String title = '';
  String descripVideo = '';
  String alumno = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardar video'),
        elevation: 0,
        backgroundColor: Colors.black26,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: decorationCustom(),
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0, left: 8, right: 8),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 82, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: Image.memory(
                                  widget.thumbnails.imageUrl,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 200.0,
                                ).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  onChanged: (String value) {
                                    title = value;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Título',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  onChanged: (String value) {
                                    descripVideo = value;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Descripción',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        Duration elapsedTimeTemp = Duration(
                                            seconds: widget.thumbnails.timeMs);

                                        var elapsedTimeString =
                                            "${elapsedTimeTemp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(elapsedTimeTemp.inSeconds.remainder(60)).toString().padLeft(2, '0')}";

                                        // var save = await GallerySaver.saveVideo(
                                        // widget.filePath);
                                        var video = VideoBD(
                                            urlVideo: widget.filePath,
                                            title: title,
                                            descriptionVideo: descripVideo,
                                            name: alumno,
                                            imgage: widget.thumbnails.imageUrl,
                                            time: elapsedTimeString,
                                            listThumbnail: [],
                                            timeRecoded: DateTime.now(),
                                            listRecoded: []);

                                        var req = await saveCV
                                            .updateImagComments(video);

                                        if (req) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Guardar'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancelar'),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
