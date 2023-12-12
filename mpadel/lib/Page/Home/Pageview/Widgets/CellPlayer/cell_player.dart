import 'package:Klasspadel/Models/player_model.dart';
import 'package:Klasspadel/Page/Home/Pageview/Widgets/avatarMiniUser.dart';
import 'package:flutter/material.dart';

class CellPlayer extends StatefulWidget {
  const CellPlayer({super.key, required this.player});
  final PlayerModel player;
  @override
  State<CellPlayer> createState() => _CellPlayerState();
}

class _CellPlayerState extends State<CellPlayer> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: 60,
      height: 80,
      color: Colors.transparent,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 59,
              width: 59,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/onboarding3.png'),
                  fit: BoxFit.fill,
                ),
                color: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            color: Colors.transparent,
            height: 30,
            width: size.width,
            child: Text(
              textAlign: TextAlign.center,
              widget.player.idPlayer,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
