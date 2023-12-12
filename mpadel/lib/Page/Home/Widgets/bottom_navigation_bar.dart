import 'package:Klasspadel/Page/AddUser/AddUser/add_user_page.dart';
import 'package:Klasspadel/Page/Plan/PageView/sub_coach.dart';
import 'package:Klasspadel/Page/Recoder/PageView/recoder_page.dart';
import 'package:Klasspadel/Page/Search/filter_screen.dart';
import 'package:Klasspadel/Page/Search/search_list_result.dart';
import 'package:Klasspadel/Page/SearchCoach/search_coach_page.dart';
import 'package:flutter/material.dart';

import '../../UserData/PageView/userScreen.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  State<BottomNavigationBarCustom> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 60,
      child: Stack(
        children: [
          Container(
            height: 85,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
          ),
          Center(
            heightFactor: 1,
            child: FloatingActionButton(
              key: const Key("recoder"),
              backgroundColor: Colors.transparent,
              elevation: 0.1,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecoderVideoPage()),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                            20.0) //                 <--- border radius here
                        ),
                    color: Colors.red),
                height: 40,
                width: 40,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(300.0),
                      child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.transparent,
                  width: 40,
                  height: 70,
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          print("object");
                        },
                        icon: Container(
                          width: 18,
                          height: 17,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/favorite.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // icon
                      Positioned(
                        bottom: 12,
                        child: Container(
                          width: 40,
                          color: Colors.transparent,
                          child: const Center(
                            child: Text(
                              "Favorito",
                              style: TextStyle(
                                  color: Color.fromRGBO(123, 123, 123, 1),
                                  fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ), // text
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: 40,
                  height: 70,
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          print("object");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        },
                        icon: Container(
                          width: 18,
                          height: 17,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Vector-3.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // icon
                      Positioned(
                        bottom: 12,
                        child: Container(
                          width: 40,
                          color: Colors.transparent,
                          child: const Center(
                            child: Text(
                              "Search",
                              style: TextStyle(
                                  color: Color.fromRGBO(123, 123, 123, 1),
                                  fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ), // text
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.20,
                ),
                Container(
                  color: Colors.transparent,
                  width: 40,
                  height: 70,
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          print("object");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPlayerScreen(),
                            ),
                          );
                        },
                        icon: Container(
                          width: 18,
                          height: 17,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Vector-4.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // icon
                      Positioned(
                        bottom: 12,
                        child: Container(
                          width: 40,
                          color: Colors.transparent,
                          child: const Center(
                            child: Text(
                              "Perfil",
                              style: TextStyle(
                                  color: Color.fromRGBO(123, 123, 123, 1),
                                  fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ), // text
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: 40,
                  height: 70,
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          print("object");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCoach(),
                            ),
                          );
                        },
                        icon: Container(
                          width: 18,
                          height: 17,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Group.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // icon
                      Positioned(
                        bottom: 12,
                        child: Container(
                          width: 40,
                          color: Colors.transparent,
                          child: const Center(
                            child: Text(
                              "Settings",
                              style: TextStyle(
                                  color: Color.fromRGBO(123, 123, 123, 1),
                                  fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ), // text
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
