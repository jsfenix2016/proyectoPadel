import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/Home/Pageview/Widgets/avatarMiniUser.dart';
import 'package:flutter/material.dart';

class CellTeacher extends StatefulWidget {
  const CellTeacher({super.key, required this.item});
  final VideoBD item;
  @override
  State<CellTeacher> createState() => _CellTeacherState();
}

class _CellTeacherState extends State<CellTeacher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.memory(
                      widget.item.imgage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  AvatarMiniUser(
                    item: widget.item,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(9),
                    bottomRight: Radius.circular(9),
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Column(
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      textAlign: TextAlign.center,
                      widget.item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Text(
                        style: const TextStyle(
                          color: Colors.yellow,
                        ),
                        widget.item.descriptionVideo,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: Text(
              widget.item.time,
              style: const TextStyle(
                backgroundColor: Colors.black,
                color: Colors.yellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
