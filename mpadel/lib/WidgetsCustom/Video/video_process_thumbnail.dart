import 'package:Klasspadel/Models/videobd.dart';
import 'package:flutter/material.dart';

class VideoProcessThumbnail extends StatefulWidget {
  const VideoProcessThumbnail({super.key, required this.item});
  final VideoBD item;
  @override
  State<VideoProcessThumbnail> createState() => _VideoProcessThumbnailState();
}

class _VideoProcessThumbnailState extends State<VideoProcessThumbnail> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 5,
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: widget.item.listThumbnail.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.memory(
              widget.item.listThumbnail[index].imageUrl,
              height: 30,
              width: 50,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
