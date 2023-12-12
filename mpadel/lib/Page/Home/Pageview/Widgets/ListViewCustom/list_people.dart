import 'package:Klasspadel/Common/colors_palette.dart';
import 'package:Klasspadel/Models/userbd.dart';
import 'package:Klasspadel/Page/Home/Pageview/Widgets/cell_people_custom.dart';
import 'package:flutter/material.dart';

class ListCustomPeople extends StatelessWidget {
  const ListCustomPeople({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Column(
          children: [
            Container(
              height: 60,
              width: size.width,
              color: Colors.black.withAlpha(50),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: ColorPalette.activeSwitch,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(
                        10.0) //                 <--- border radius here
                    ),
                color: Colors.red.withAlpha(50)),
            height: 150,
            width: size.width,
            child: Row(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        height: 250,
                        width: size.width / 1.09,
                        child: FutureBuilder<List<UserBD>>(
                          future: null,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final item = snapshot.data![index];
                                    return GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: CellPeopleCustom(),
                                        ));
                                  },
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Error al cargar los items'));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: (250 / 2) - 50,
                      right: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: ColorPalette.activeSwitch,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        height: 50,
                        width: 50,
                        child: IconButton(
                          iconSize: 20,
                          onPressed: (() {}),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
