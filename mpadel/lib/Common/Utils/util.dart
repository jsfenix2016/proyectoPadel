import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {}

TextStyle styleCustomGoodTimesWhite() {
  return const TextStyle(
    fontFamily: 'GoodTimes',
    fontSize: 18.0,
    wordSpacing: 1,
    letterSpacing: 0.001,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}

TextStyle styleCustomGoodTimes() {
  return const TextStyle(
    fontFamily: 'GoodTimes',
    fontSize: 18.0,
    wordSpacing: 1,
    letterSpacing: 0.001,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}

TextStyle styleCustomGoodTimesBold() {
  return const TextStyle(
    fontFamily: 'GoodTimes',
    fontSize: 18.0,
    wordSpacing: 1,
    letterSpacing: 0.001,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

MaterialColor colorController(int position) {
  switch (position) {
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    case 3:
      return Colors.yellow;
    case 4:
      return Colors.blue;
    default: // Without this, you see a WARNING.
  }
  return Colors.brown;
}

Future<Uint8List> loadImage(String path) async {
  final byteData = await rootBundle.load(path);
  return byteData.buffer.asUint8List();
}
