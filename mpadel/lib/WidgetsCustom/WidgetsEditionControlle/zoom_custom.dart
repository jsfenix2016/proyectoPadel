import 'package:flutter/material.dart';

class ZoomCustom extends StatefulWidget {
  ZoomCustom({super.key, required this.zoomActived});
  bool zoomActived;
  @override
  State<ZoomCustom> createState() => _ZoomCustomState();
}

class _ZoomCustomState extends State<ZoomCustom> {
  late Offset dragGesturePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.zoomActived,
      child: Stack(children: <Widget>[
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) => setState(
            () {
              dragGesturePosition = details.localPosition;
            },
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height should be fixed for vertical scrolling
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // adding borders around the widget
              border: Border.all(
                color: Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
        ),
        Positioned(
          left: dragGesturePosition.dx -
              90, // Resta la mitad del ancho de la lupa
          top:
              dragGesturePosition.dy - 90, // Resta la mitad del alto de la lupa

          child: const RawMagnifier(
            decoration: MagnifierDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 3),
              ),
            ),
            size: Size(220, 180),
            magnificationScale: 1.6,
          ),
        ),
      ]),
    );
  }
}
