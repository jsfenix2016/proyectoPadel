import 'dart:async';
import 'dart:convert';
import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Common/colors_palette.dart';
import 'package:Klasspadel/Common/decoder_custom.dart';
import 'package:Klasspadel/Models/player_model.dart';
import 'package:Klasspadel/Models/userbd.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/AddUser/AddUser/add_user_page.dart';
import 'package:Klasspadel/Page/EditVideo/PageView/editVideoScreen.dart';
import 'package:Klasspadel/Page/Home/Controller/homeController.dart';
import 'package:Klasspadel/Page/Home/Pageview/Widgets/CellPlayer/cell_player.dart';
import 'package:Klasspadel/Page/Home/Pageview/Widgets/CellTeachers/cellteacher.dart';
import 'package:Klasspadel/Page/Home/Widgets/bottom_navigation_bar.dart';
import 'package:Klasspadel/Page/Home/Widgets/card_performance.dart';
import 'package:Klasspadel/Page/Home/Widgets/card_player.dart';
import 'package:Klasspadel/Page/ListVideoTeachers/PageView/listvideoteacher.dart';
import 'package:Klasspadel/Page/UserData/PageView/userScreen.dart';
import 'package:Klasspadel/Page/UserData/linearchart.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/edit_button_expand.dart';
import 'package:Klasspadel/WidgetsCustom/video_player_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Klasspadel/Page/MenuHamburger/Menuview/menuHamburgerScreen.dart';
import 'package:Klasspadel/Page/Recoder/PageView/recoder_page.dart';
import 'dart:io' show Directory, File, Platform;

// final _prefs = PreferenceUser();

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.typeUser});
  final String typeUser;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeVC = Get.put(HomeController());
  late bool selectImage = false;
  late String nameComplete;
  late List<VideoBD> listVideo = [];
  late List<PlayerModel> listPlayer = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  var position = -20.0;

  var isOpen = false;
  // User? user;
  UserBD? userbd;

  late Image imgNew;

  @override
  void initState() {
    getAllMyVideo();
    var a = widget.typeUser;
    getAllPlayer();
    super.initState();
  }

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<List<PlayerModel>> getAllPlayer() async {
    List<PlayerModel> listPlayerTemp = await homeVC.getAllPlayer();

    if (listPlayerTemp.isNotEmpty) {
      listPlayer = listPlayerTemp;
      return listPlayerTemp;
    } else {
      return [];
    }
  }

  Future<List<VideoBD>> getAllMyVideo() async {
    listVideo = await homeVC.getAllMyVideos();

    if (listVideo.isNotEmpty) {
      return listVideo;
    } else {
      return [];
    }
  }

  // void diveceInfo() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     // Android-specific code
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"

  //   } else if (Platform.isIOS) {
  //     // iOS-specific code
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"

  //   }
  // }

//capturar imagen de la galeria de fotos
  // Future getImageGallery(ImageSource origen) async {
  //   final XFile? image = await _picker.pickImage(source: origen);
  //   File file;

  //   if (image != null) {
  //     file = File(image.path);
  //     setState(() {
  //       foto = file;
  //     });
  //   }
  // }

  Image getImage(String urlImage) {
    Uint8List bytesImages = const Base64Decoder().convert(urlImage);

    return imgNew = Image.memory(bytesImages,
        fit: BoxFit.cover, width: double.infinity, height: 250.0);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // if (userbd != null) {
    //   nameComplete = userbd!.name + userbd!.lastname;
    // } else {
    nameComplete = "Usuario";
    // }

    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarCustom(),
      drawer: const MenuHamburgerPage(),
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: decorationCustom(),
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 50,
                width: size.width,
                color: Colors.transparent,
                child: Container(
                  height: 150,
                  width: size.width,
                  color: const Color.fromRGBO(255, 154, 0, 0.88),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const AlertsPage()),
                          // );
                        },
                        icon: const Icon(
                          Icons.menu,
                        ),
                      ),
                      Container(
                        width: 138,
                        height: 27,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Group 39248.png'),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                      IconButton(
                        iconSize: 40,
                        color: Colors.amber,
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const AlertsPage()),
                          // );
                        },
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 32,
                            width: 28,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/onboarding3.png'),
                                fit: BoxFit.fill,
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemCount: 4,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPlayerScreen(),
                                ),
                              );
                            },
                            child: const CardPlayer());
                      } else if (index == 1) {
                        return const CardPerformance();
                      } else if (index == 2) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withAlpha(50),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        10.0) //                 <--- border radius here
                                    ),
                                color: Colors.black.withAlpha(50)),
                            height: 155,
                            width: size.width,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 14, left: 18.0),
                                      child: Text(
                                        "My Teacher",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          wordSpacing: 1,
                                          letterSpacing: 0.001,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 19, right: 30.0),
                                      child: Container(
                                        color: Colors.transparent,
                                        child: const Text(
                                          "view all",
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            wordSpacing: 1,
                                            letterSpacing: 0.001,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),

                                    // Positioned(
                                    //   top: (250 / 2) - 50,
                                    //   right: 10,
                                    //   child: Container(
                                    //     decoration: const BoxDecoration(
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //           color: Colors.black,
                                    //           spreadRadius: 1,
                                    //           blurRadius: 6,
                                    //           offset: Offset(0,
                                    //               3), // changes position of shadow
                                    //         ),
                                    //       ],
                                    //       color: ColorPalette.activeSwitch,
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(100)),
                                    //     ),
                                    //     height: 50,
                                    //     width: 50,
                                    //     child: IconButton(
                                    //       iconSize: 20,
                                    //       onPressed: (() {
                                    //         Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) =>
                                    //                   AddUserPage(
                                    //                     list: listPlayer,
                                    //                   )),
                                    //         );
                                    //       }),
                                    //       icon: const Icon(
                                    //         Icons.add,
                                    //         color: Colors.white,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 101,
                                    width: size.width / 1.06,
                                    child: FutureBuilder<List<PlayerModel>>(
                                      future: getAllPlayer(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    snapshot.data![index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    print("object");

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AddPlayerScreen()),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: CellPlayer(
                                                      player: item,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Center(
                                              child: Text(
                                                  'Error al cargar los items'));
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
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
                                      child: FutureBuilder<List<VideoBD>>(
                                        future: getAllMyVideo(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  final item =
                                                      snapshot.data![index];
                                                  return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditVideoPage(
                                                                    item: item,
                                                                  )),
                                                        );
                                                      },
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: CellTeacher(
                                                          item: item,
                                                        ),
                                                      ));
                                                },
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Center(
                                                child: Text(
                                                    'Error al cargar los items'));
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: ColorPalette.activeSwitch,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                      ),
                                      height: 50,
                                      width: 50,
                                      child: IconButton(
                                        iconSize: 20,
                                        onPressed: (() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ListVideoTeacher()),
                                          );
                                        }),
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
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Stack(
//           fit: StackFit.expand,
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           children: <Widget>[
//             Positioned(
//               top: 35,
//               right: 16,
//               child: IconButton(
//                 iconSize: 40,
//                 color: Colors.amber,
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => const AlertsPage()),
//                   // );
//                 },
//                 icon: Container(
//                   height: 32,
//                   width: 28,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/Unknown.png'),
//                       fit: BoxFit.fill,
//                     ),
//                     color: Colors.transparent,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 50,
//               child: Container(
//                 width: size.width,
//                 color: Colors.transparent,
//                 child: Text(
//                   "Bienvenido $nameComplete",
//                   style: const TextStyle(
//                       color: ColorPalette.activeSwitch,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 100.0),
//               child: ListView(
//                 physics: const ClampingScrollPhysics(),
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         height: 50,
//                         width: size.width,
//                         color: Colors.black.withAlpha(50),
//                         child: const Center(
//                           child: Text(
//                             "Alumnos",
//                             style: TextStyle(
//                                 color: ColorPalette.activeSwitch,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: const BorderRadius.all(
//                                   Radius.circular(
//                                       10.0) //                 <--- border radius here
//                                   ),
//                               color: Colors.red.withAlpha(50)),
//                           height: 150,
//                           width: size.width,
//                           child: Row(
//                             children: [
//                               Stack(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(4.0),
//                                     child: SizedBox(
//                                       height: 250,
//                                       width: size.width / 1.09,
//                                       child: FutureBuilder<List<PlayerModel>>(
//                                         future: getAllPlayer(),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.hasData) {
//                                             return Padding(
//                                               padding:
//                                                   const EdgeInsets.all(3.0),
//                                               child: ListView.builder(
//                                                 scrollDirection:
//                                                     Axis.horizontal,
//                                                 itemCount:
//                                                     snapshot.data!.length,
//                                                 itemBuilder: (context, index) {
//                                                   final item =
//                                                       snapshot.data![index];
//                                                   return GestureDetector(
//                                                     onTap: () {},
//                                                     child: Card(
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(16),
//                                                       ),
//                                                       child: CellPlayer(
//                                                         player: item,
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                             );
//                                           } else if (snapshot.hasError) {
//                                             return const Center(
//                                                 child: Text(
//                                                     'Error al cargar los items'));
//                                           } else {
//                                             return const Center(
//                                                 child:
//                                                     CircularProgressIndicator());
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: (250 / 2) - 50,
//                                     right: 10,
//                                     child: Container(
//                                       decoration: const BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black,
//                                             spreadRadius: 1,
//                                             blurRadius: 6,
//                                             offset: Offset(0,
//                                                 3), // changes position of shadow
//                                           ),
//                                         ],
//                                         color: ColorPalette.activeSwitch,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(100)),
//                                       ),
//                                       height: 50,
//                                       width: 50,
//                                       child: IconButton(
//                                         iconSize: 20,
//                                         onPressed: (() {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     AddUserPage(
//                                                       list: listPlayer,
//                                                     )),
//                                           );
//                                         }),
//                                         icon: const Icon(
//                                           Icons.add,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 60,
//                         width: size.width,
//                         color: Colors.black.withAlpha(50),
//                         child: const Center(
//                           child: Text(
//                             "Mis videos grabados. (profesor)",
//                             style: TextStyle(
//                                 color: ColorPalette.activeSwitch,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.all(Radius.circular(
//                                   10.0) //                 <--- border radius here
//                               ),
//                           color: Colors.red.withAlpha(50)),
//                       height: 150,
//                       width: size.width,
//                       child: Row(
//                         children: [
//                           Stack(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: SizedBox(
//                                   height: 250,
//                                   width: size.width / 1.09,
//                                   child: FutureBuilder<List<VideoBD>>(
//                                     future: getAllMyVideo(),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.hasData) {
//                                         return Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: ListView.builder(
//                                             scrollDirection: Axis.horizontal,
//                                             itemCount: snapshot.data!.length,
//                                             itemBuilder: (context, index) {
//                                               final item =
//                                                   snapshot.data![index];
//                                               return GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               EditVideoPage(
//                                                                 item: item,
//                                                               )),
//                                                     );
//                                                   },
//                                                   child: Card(
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               16),
//                                                     ),
//                                                     child: CellTeacher(
//                                                       item: item,
//                                                     ),
//                                                   ));
//                                             },
//                                           ),
//                                         );
//                                       } else if (snapshot.hasError) {
//                                         return const Center(
//                                             child: Text(
//                                                 'Error al cargar los items'));
//                                       } else {
//                                         return const Center(
//                                             child: CircularProgressIndicator());
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: (250 / 2) - 50,
//                                 right: 10,
//                                 child: Container(
//                                   decoration: const BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black,
//                                         spreadRadius: 1,
//                                         blurRadius: 6,
//                                         offset: Offset(
//                                             0, 3), // changes position of shadow
//                                       ),
//                                     ],
//                                     color: ColorPalette.activeSwitch,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(100)),
//                                   ),
//                                   height: 50,
//                                   width: 50,
//                                   child: IconButton(
//                                     iconSize: 20,
//                                     onPressed: (() {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const ListVideoTeacher()),
//                                       );
//                                     }),
//                                     icon: const Icon(
//                                       Icons.add,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: -1,
//               left: 0,
//               child: SizedBox(
//                 width: size.width,
//                 height: 80,
//                 child: Stack(
//                   children: [
//                     Container(
//                       height: 85,
//                       decoration: const BoxDecoration(
//                         color: ColorPalette.secondView,
//                       ),
//                     ),
//                     Center(
//                       heightFactor: 1,
//                       child: FloatingActionButton(
//                         key: const Key("recoder"),
//                         backgroundColor: Colors.transparent,
//                         elevation: 0.1,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const RecoderVideoPage()),
//                           );
//                         },
//                         child: Container(
//                           decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage('assets/images/camera.png'),
//                                 fit: BoxFit.fill,
//                               ),
//                               borderRadius: BorderRadius.all(Radius.circular(
//                                       20.0) //                 <--- border radius here
//                                   ),
//                               color: ColorPalette.activeSwitch),
//                           height: 40,
//                           width: 40,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: size.width,
//                       height: 80,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Stack(
//                             children: [
//                               Positioned(
//                                 right: 7,
//                                 top: 5,
//                                 child: Visibility(
//                                   visible: true,
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(
//                                                 20.0) //                 <--- border radius here
//                                             ),
//                                         color: Colors.red),
//                                     height: 10,
//                                     width: 10,
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.settings,
//                                   color: currentIndex == 0
//                                       ? ColorPalette.activeSwitch
//                                       : Colors.grey.shade400,
//                                 ),
//                                 onPressed: () {
//                                   setBottomBarIndex(0);
//                                 },
//                                 splashColor: Colors.white,
//                               ),
//                             ],
//                           ),
//                           Container(
//                             width: size.width * 0.20,
//                           ),
//                           IconButton(
//                               icon: Icon(
//                                 Icons.add_alert,
//                                 color: currentIndex == 3
//                                     ? ColorPalette.activeSwitch
//                                     : Colors.grey.shade400,
//                               ),
//                               onPressed: () {
//                                 setBottomBarIndex(3);
//                               }),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )