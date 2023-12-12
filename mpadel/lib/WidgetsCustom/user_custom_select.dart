import 'package:flutter/material.dart';

class UserCustomSelect extends StatefulWidget {
  const UserCustomSelect(
      {super.key,
      required this.isFilter,
      required this.name,
      required this.onDelete});
  final String name;
  final bool isFilter;
  final void Function(bool) onDelete;
  @override
  State<UserCustomSelect> createState() => _UserCustomSelectState();
}

class _UserCustomSelectState extends State<UserCustomSelect> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: const Offset(
                0.0,
                2.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ), //BoxShadow
            const BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0, 1),
            colors: <Color>[
              Color.fromRGBO(255, 154, 0, 0.88),
              Color.fromARGB(255, 230, 48, 48),
            ],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.amberAccent,
        ),
        height: 150,
        width: size.width * 0.95,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 100,
                height: 130,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/onboarding3.png'),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 120,
              child: Container(
                width: 230,
                height: 150,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Ranking: 14',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 75,
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blue,
                          ),
                          child: const Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Diestro: 04',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 75,
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blue,
                          ),
                          child: const Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Reves: 14',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !widget.isFilter,
              child: Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    widget.onDelete(false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
