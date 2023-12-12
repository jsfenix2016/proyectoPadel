import 'package:Klasspadel/Common/colors_palette.dart';
import 'package:flutter/material.dart';

class DecoderCustom {}

BoxDecoration decorationCustomWhite() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment(0, 2),
      colors: <Color>[
        Colors.white,
        Colors.white,
        Colors.white,
      ],
      tileMode: TileMode.mirror,
    ),
  );
}

BoxDecoration decorationCustom() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment(0, 2),
      colors: <Color>[
        ColorPalette.principalView,
        ColorPalette.principalView,
      ],
      tileMode: TileMode.decal,
    ),
  );
}

BoxDecoration decorationOnboarding() {
  return BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment(0, 1),
      colors: <Color>[
        Colors.black,
        Colors.black,
        Colors.black,
      ],
      tileMode: TileMode.mirror,
    ),
    borderRadius: BorderRadius.circular(5.0),
    boxShadow: const <BoxShadow>[
      BoxShadow(
          color: Colors.yellow,
          blurRadius: 3.0,
          offset: Offset(0.0, 5.0),
          spreadRadius: 3.0),
    ],
  );
}
