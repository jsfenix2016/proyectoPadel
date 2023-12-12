import 'package:Klasspadel/Models/thumbnail.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class ContainerListRecoder extends StatefulWidget {
  const ContainerListRecoder(
      {super.key,
      required this.listThumbnail,
      required this.onDelete,
      required this.onShowThumb,
      required this.onClose});

  final List<Thumbnail> listThumbnail;
  final ValueChanged<int> onDelete;
  final ValueChanged<int> onShowThumb;
  final ValueChanged<bool> onClose;

  @override
  State<ContainerListRecoder> createState() => _ContainerListRecoderState();
}

class _ContainerListRecoderState extends State<ContainerListRecoder> {
  //create a new player
  final assetsAudioPlayer = AssetsAudioPlayer();
  int indexSelect = -1;
  bool isPlay = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 65.0, bottom: 60, top: 10),
      child: Container(
        width: size.width - 75,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(219, 177, 42, 1)),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white.withAlpha(80),
        ),
        child: Column(
          children: [
            Container(
              width: size.width - 75,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Colors.white.withAlpha(80),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 5,
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: IconButton(
                        iconSize: 20,
                        icon: const Icon(Icons.close, color: Colors.black),
                        tooltip: 'Cerrar',
                        onPressed: () {
                          widget.onClose(true);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: 60,
                    child: Container(
                      color: Colors.transparent,
                      height: 40,
                      width: 200,
                      child: const Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Lista de grabaciones',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: widget.listThumbnail.length,
                  itemBuilder: (BuildContext context, int index) {
                    var elapsedTimeDuration = Duration(
                        seconds: int.parse(
                            widget.listThumbnail[index].timeDurationRecoded));
                    String elapsedTimeString =
                        "${elapsedTimeDuration.inHours.remainder(60).toString().padLeft(2, '0')}:${elapsedTimeDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(elapsedTimeDuration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";

                    return GestureDetector(
                      onTap: () {
                        print(widget.listThumbnail[index].pathRecoded);

                        widget.onShowThumb(index);
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 2.0, right: 2, top: 4),
                            child: Container(
                              height: 60,
                              width: size.width * 0.775,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: Colors.black.withAlpha(80),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        widget
                                            .listThumbnail[index].titleRecoded,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          decoration: TextDecoration.none,
                                        )),
                                    IconButton(
                                        icon: Container(
                                          height: 40.0,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withAlpha(70),
                                            border: Border.all(
                                                color: const Color.fromRGBO(
                                                    219, 177, 42, 1)),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: Icon(
                                            !isPlay && indexSelect == index
                                                ? Icons.play_arrow
                                                : Icons.stop,
                                            color: Colors.white,
                                          ),
                                        ),
                                        tooltip: 'Play and Stop',
                                        onPressed: () async {
                                          if (isPlay && indexSelect == index) {
                                            isPlay = false;
                                            assetsAudioPlayer.stop();
                                          } else {
                                            indexSelect = index;
                                            isPlay = true;

                                            assetsAudioPlayer.open(
                                              Audio.file(widget
                                                  .listThumbnail[index]
                                                  .pathRecoded),
                                            );
                                            assetsAudioPlayer.play();
                                          }
                                          setState(() {});
                                        }),
                                    Text(
                                      elapsedTimeString.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      height: 50,
                                      width: 50,
                                      child: Center(
                                        child: Image.memory(
                                            widget
                                                .listThumbnail[index].imageUrl!,
                                            fit: BoxFit.contain,
                                            width: 50,
                                            height: 50.0),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.white),
                                      tooltip: 'Clear',
                                      onPressed: () {
                                        print('Delete');

                                        widget.onDelete(index);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
