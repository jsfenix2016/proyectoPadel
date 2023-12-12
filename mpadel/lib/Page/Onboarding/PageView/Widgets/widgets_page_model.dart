import 'package:Klasspadel/Common/decoder_custom.dart';
import 'package:flutter/material.dart';

class PageModalCustomBody extends StatelessWidget {
  final String urlImg;
  final String textDescription;
  final String title;
  const PageModalCustomBody(
      {super.key,
      required this.urlImg,
      required this.title,
      required this.textDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 500,
      decoration: decorationOnboarding(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            urlImg,
            width: double.infinity,
            height: 300,
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 23.0,
                  wordSpacing: 1,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              textDescription,
              style: const TextStyle(fontSize: 16, color: Colors.yellow),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
