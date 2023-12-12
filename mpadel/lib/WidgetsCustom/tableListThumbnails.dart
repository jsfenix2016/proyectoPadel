import 'package:Klasspadel/Models/thumbnail.dart';
import 'package:Klasspadel/Models/thumbnailbd.dart';
import 'package:flutter/material.dart';

class TableListThumbnails extends StatefulWidget {
  const TableListThumbnails(
      {super.key, required this.list, required this.onChanged});
  final List<ThumbnailBD> list;
  final ValueChanged<ThumbnailBD> onChanged;
  @override
  State<TableListThumbnails> createState() => _TableListThumbnailsWidgetState();
}

class _TableListThumbnailsWidgetState extends State<TableListThumbnails> {
  double _xPosition = 250;
  double _yPosition = 150;

  @override
  Widget build(BuildContext context) {
    double maxTableHeight = 70 * 5 + 80; // Altura máxima para 5 elementos

    return Positioned(
      left: _xPosition,
      top: _yPosition,
      child: GestureDetector(
        onPanUpdate: (dragUpdate) {
          setState(() {
            _xPosition += dragUpdate.delta.dx;
            _yPosition += dragUpdate.delta.dy;
          });
        },
        child: Container(
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.amber,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: Colors.transparent,
                  ),
                  constraints: BoxConstraints(
                    minHeight: widget.list.length * 70,
                    maxHeight: maxTableHeight,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 5);
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onChanged(widget.list[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 60,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              color: Colors.red,
                              child: Image.memory(
                                widget.list[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.games,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
