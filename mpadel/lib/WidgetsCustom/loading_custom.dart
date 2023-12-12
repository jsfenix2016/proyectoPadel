import 'package:flutter/material.dart';

class LoadingCustom extends StatefulWidget {
  const LoadingCustom({
    super.key,
  });

  @override
  State<LoadingCustom> createState() => _LoadingCustomState();
}

class _LoadingCustomState extends State<LoadingCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllerGift;

  @override
  void initState() {
    _controllerGift = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controllerGift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: RotationTransition(
          turns: _controllerGift,
          child: Image.asset('assets/images/pelotaGiratoria.gif',
              height: 125.0, width: 125.0, gaplessPlayback: true),
        ),
      ),
    );
  }
}
