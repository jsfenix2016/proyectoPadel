import 'package:flutter/material.dart';

class CardPlayer extends StatelessWidget {
  const CardPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0, 1),
          colors: <Color>[
            Color.fromRGBO(255, 154, 0, 0.88),
            Color.fromARGB(255, 230, 48, 48),
          ],
          tileMode: TileMode.mirror,
        ),
        color: Colors.green,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      height: size.height * 0.350,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromRGBO(185, 22, 40, 0.36),
          ),
          width: 280,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 150,
                    width: 180,
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          child: const Text(
                            "Card Player",
                            style: TextStyle(
                              fontSize: 12.0,
                              wordSpacing: 1,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 40,
                        ),
                        Container(
                          width: 200,
                          child: const Text(
                            "Javier",
                            style: TextStyle(
                              fontSize: 14.0,
                              wordSpacing: 1,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 5,
                        ),
                        Container(
                          width: 200,
                          child: const Text(
                            "SANTANA",
                            style: TextStyle(
                              fontSize: 23.0,
                              wordSpacing: 1,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          width: 200,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: const Text(
                                  "Diestro: 03",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    wordSpacing: 1,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                width: 20,
                              ),
                              Container(
                                child: const Text(
                                  "Reves: 05",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    wordSpacing: 1,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 100,
                    color: Colors.blue,
                    child: Image.asset(
                      fit: BoxFit.fill,
                      'assets/images/onboarding2.png',
                      width: 100,
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
