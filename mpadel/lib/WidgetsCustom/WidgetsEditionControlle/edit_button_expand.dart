import 'package:Klasspadel/Page/EditVideo/PageView/editVideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

class EditButtonExpand extends StatefulWidget {
  final ValueChanged<PainterController> onChanged;
  final ValueChanged<bool> onDelete;
  final ValueChanged<bool> onUndo;
  final ValueChanged<bool> onZoom;
  final ValueChanged<bool> onPreview;
  final ValueChanged<bool> onList;
  const EditButtonExpand(
      {Key? key,
      required this.onChanged,
      required this.onDelete,
      required this.onUndo,
      required this.onZoom,
      required this.onPreview,
      required this.onList})
      : super(key: key);

  static PainterController newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  @override
  State<EditButtonExpand> createState() => _EditButtonExpandState();
}

class _EditButtonExpandState extends State<EditButtonExpand>
    with SingleTickerProviderStateMixin {
  late PainterController controller = EditButtonExpand.newController();
  bool isEdit = false;
  bool isExpanded = false;
  bool isZoomActived = false;
  bool isListActived = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Asegúrate de cancelar el temporizador al eliminar el widget.
    super.dispose();
    controller.dispose();
  }

  void expandedController() {
    if (isExpanded) {
      isExpanded = false;
    } else {
      isExpanded = true;
    }

    setState(() {});
  }

  void editBtn() {
    if (isEdit) {
      isEdit = false;
    } else {
      isEdit = true;
    }
    widget.onChanged(controller);
    setState(() {});
  }

  void previewBtn() {
    widget.onPreview(true);
    setState(() {});
  }

  void showList() {
    if (isListActived) {
      isListActived = false;
    } else {
      isListActived = true;
    }
    widget.onList(true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(70),
            border: Border.all(color: const Color.fromRGBO(219, 177, 42, 1)),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          width: 50, // Anima el ancho
          height: isExpanded ? 390.0 : 50.0, // Anima el alto
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: isExpanded
                              ? const Icon(
                                  Icons.close,
                                )
                              : const Icon(
                                  Icons.arrow_drop_down,
                                ),
                          tooltip: 'Expanded',
                          onPressed: expandedController),
                      Visibility(
                        visible: isExpanded,
                        child: Column(
                          children: [
                            DrawBar(controller, isEdit, (bool value) {
                              editBtn();
                            }),
                            IconButton(
                                icon: const Icon(
                                  Icons.undo,
                                ),
                                tooltip: 'Atras',
                                onPressed: () async {
                                  widget.onUndo(true);
                                }),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                tooltip: 'Borrar todo',
                                onPressed: () {
                                  controller.clear();
                                }),
                            IconButton(
                              icon: const Icon(Icons.preview),
                              tooltip: 'Vista previa',
                              onPressed: previewBtn,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.zoom_in,
                                color: !isZoomActived
                                    ? Colors.amber
                                    : Colors.black,
                              ),
                              tooltip: 'Zoom',
                              onPressed: () {
                                if (isZoomActived) {
                                  isZoomActived = false;
                                } else {
                                  isZoomActived = true;
                                }
                                widget.onZoom(isZoomActived);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.list,
                                color:
                                    isListActived ? Colors.amber : Colors.black,
                              ),
                              tooltip: 'Lista',
                              onPressed: showList,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
