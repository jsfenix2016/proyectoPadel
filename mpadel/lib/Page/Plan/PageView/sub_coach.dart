import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Common/decoder_custom.dart';
import 'package:Klasspadel/WidgetsCustom/checkbox_custom.dart';
import 'package:flutter/material.dart';

class SubCoach extends StatefulWidget {
  const SubCoach({super.key});

  @override
  State<SubCoach> createState() => _SubCoachState();
}

class _SubCoachState extends State<SubCoach> {
  late bool terms = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: decorationCustom(),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.transparent,
                  height: 15,
                  width: 70,
                ),
                const Text(
                  "Klass Padel",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                Container(
                  color: Colors.transparent,
                  height: 15,
                  width: 70,
                ),
                const Text(
                  "Tú subscripción",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                Container(
                  color: Colors.transparent,
                  height: 15,
                  width: 70,
                ),
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SILVER",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(219, 177, 42, 1)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.amber),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 10),
                            const Text("description"),
                            const SizedBox(height: 10),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: 100,
                                    width: 1,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        color: Colors.transparent,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '3.99/',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text('mes'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 1,
                                        width: 90,
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        height: 50,
                                        width: 90,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text(
                                                    '36/',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text('año'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "GOLD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(219, 177, 42, 1)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.amber),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 10),
                            const Text("description"),
                            const SizedBox(height: 10),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: 100,
                                    width: 1,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 90,
                                        color: Colors.transparent,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text(
                                                    '5.99/',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text('mes'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 1,
                                        width: 90,
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        height: 50,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '60/',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text('año'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "PLATINUM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(219, 177, 42, 1)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.amber),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 10),
                            const Text("description"),
                            const SizedBox(height: 10),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: 100,
                                    width: 1,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 90,
                                        color: Colors.transparent,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text(
                                                    '9.99/',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text('mes'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 1,
                                        width: 90,
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        height: 50,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '99/',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text('año'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                CheckBoxCustom(
                  valueType: terms,
                  title: "Terminos y condiciones",
                  onChanged: (value) {
                    terms = value;
                    (context as Element).markNeedsBuild();
                    // setState(() {});
                  },
                  styleCustom: styleCustomGoodTimesWhite(),
                  unselectedColorCustom: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
