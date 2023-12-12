import 'package:Klasspadel/Page/UserData/linearchart.dart';
import 'package:flutter/material.dart';

class CardPerformance extends StatelessWidget {
  const CardPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withAlpha(50),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
                Radius.circular(10.0) //                 <--- border radius here
                ),
            color: Colors.black.withAlpha(50)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              height: 40,
              color: Colors.transparent,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Player Performance",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const LineChartSample2(),
          ],
        ),
      ),
    );
  }
}
