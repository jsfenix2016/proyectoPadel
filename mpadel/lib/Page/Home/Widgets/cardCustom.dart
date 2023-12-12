import 'dart:typed_data';

import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Uint8List thumbnail;
  final String subtitle;
  final Function() onPressed;

  const CardCustom(
      {required this.text,
      required this.imageUrl,
      required this.thumbnail,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Stack(
          children: [
            Container(
              key: const Key("video"),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow,
                  width: 2,
                ),
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 160,
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.memory(
                  thumbnail,
                  fit: BoxFit.fill,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
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
                  child: Image.memory(
                    thumbnail,
                    fit: BoxFit.cover,
                    height: 40,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 2,
              left: 0,
              right: 0,
              height: 40, // Ajusta esto para centrar verticalmente
              child: Container(
                color: Colors.black26,
                child: Column(
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
