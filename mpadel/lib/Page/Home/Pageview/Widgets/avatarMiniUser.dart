import 'package:Klasspadel/Models/videobd.dart';
import 'package:flutter/material.dart';

class AvatarMiniUser extends StatefulWidget {
  const AvatarMiniUser({super.key, required this.item});
  final VideoBD item;
  @override
  State<AvatarMiniUser> createState() => _AvatarMiniUserState();
}

class _AvatarMiniUserState extends State<AvatarMiniUser> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 1,
      right: 1,
      child: Container(
        key: const Key("user"),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
          color: Colors.amber,
          borderRadius: BorderRadius.circular(100),
        ),
        width: 40,
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.item.imgage == null
                    ? Image.memory(
                        widget.item.imgage,
                        fit: BoxFit.cover,
                      ).image
                    : const AssetImage("assets/images/player.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
