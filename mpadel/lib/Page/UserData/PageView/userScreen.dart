import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Models/player_model.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/Home/Pageview/Widgets/CellTeachers/cellteacher.dart';
import 'package:Klasspadel/Page/ListVideoTeachers/Controller/listVideoTeacherController.dart';
import 'package:Klasspadel/Page/ListVideoTeachers/PageView/listvideoteacher.dart';
import 'package:Klasspadel/Page/UserData/linearchart.dart';
import 'package:Klasspadel/Page/video_edit_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:image_picker/image_picker.dart';
import 'package:Klasspadel/Models/userbd.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({super.key});
  // final PlayerModel player;
  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen>
    with SingleTickerProviderStateMixin {
  final ListVideoTeacherController listVideoVC =
      Get.put(ListVideoTeacherController());
  final _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late int age;
  String _handPreference = 'Derecho';
  late int yearsOfExperience = 0;
  String _positionOnCourt = 'Drive';
  String gender = 'Selecciona tú genero';
  String level = 'Selecciona tú nivel';
  bool alumno = false;
  bool choach = false;
  bool fisical = false;

  bool pinned = true;
  bool snap = false;
  bool floating = false;
  UserBD? user;
  var foto;
  final _picker = ImagePicker();
  int _selectedIndex = 0;

  late final TabController _tabController;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: _selectedIndex);
    _pageController.addListener(_handleTabSelection);
  }

//capturar imagen de la galeria de fotos
  Future getImageGallery(ImageSource origen) async {
    final XFile? image = await _picker.pickImage(source: origen);
    File file;

    if (image != null) {
      file = File(image.path);
      setState(() {
        foto = file;
      });
    }
  }

  Image getImage(String urlImage) {
    Uint8List bytesImages = const Base64Decoder().convert(urlImage);

    return Image.memory(bytesImages,
        fit: BoxFit.cover, width: double.infinity, height: 250.0);
  }

  Widget _mostrarFoto() {
    return GestureDetector(
      onTap: (() async {
        //  var result = await cameraPermissions(_prefs.getAcceptedCamera, context);
        getImageGallery(ImageSource.gallery);
      }),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(
              Radius.circular(50.0) //                 <--- border radius here
              ),
          border: Border.all(color: Colors.yellow),
          image: DecorationImage(
            image: (foto != null)
                ? (foto != null
                    ? FileImage(foto, scale: 0.5)
                    : getImage(user!.pathImage).image)
                : const AssetImage("assets/images/logo.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.removeListener(_handleTabSelection);
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      // El índice del TabBar está cambiando debido a un deslizamiento
      // Puedes realizar acciones aquí según tus necesidades
      setState(() {
        // _selectedIndex = _tabController.index;
      });
      print("Selected Index: ${_tabController.index}");
      print('Deslizamiento en el TabBar: ${_tabController.index}');
    }
  }

  Future<List<VideoBD>> getListVideo() async {
    return await listVideoVC.getAllMyVideos();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blue,
                bottom: TabBar(
                  controller: _tabController,
                  onTap: (value) {
                    _pageController.jumpToPage(value);
                  },
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Videos',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Tab(
                        child: Text('Datos',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ))),
                  ],
                ),
                title: const Text(
                  'Mi Perfil',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.left,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.black),
                    onPressed: () {
                      getImageGallery(ImageSource.camera);
                    },
                  ),
                ],
                pinned: pinned,
                snap: snap,
                floating: floating,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: (() async {
                                //  var result = await cameraPermissions(_prefs.getAcceptedCamera, context);
                                getImageGallery(ImageSource.gallery);
                              }),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: (foto != null)
                                    ? (foto != null
                                        ? FileImage(foto, scale: 0.5)
                                        : getImage(user!.pathImage).image)
                                    : const AssetImage(
                                        "assets/images/logo.png"),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "widget.player.name",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "widget.player.position",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _tabController.animateTo(index);
            },
            children: [
              SizedBox(
                child: FutureBuilder(
                    future: getListVideo(),
                    builder: (context, state) {
                      if (state.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (state.hasData) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 2,
                            ),
                            itemCount: state.data?.length,
                            itemBuilder: (context, i) {
                              var item = state.data![i];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoEditPlayerScreen(
                                              item: item,
                                            )),
                                  );
                                },
                                child: CellTeacher(
                                  item: item,
                                ),
                              );
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    }),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Nombre'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingrese su nombre';
                          }
                          return null;
                        },
                        onSaved: (value) => firstName = value!,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Apellido'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingrese su apellido';
                          }
                          return null;
                        },
                        onSaved: (value) => lastName = value!,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Edad'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingrese su edad';
                          }
                          return null;
                        },
                        onSaved: (value) => age = int.parse(value!),
                      ),
                      DropdownButtonFormField<String>(
                        value: _handPreference,
                        onChanged: (value) =>
                            setState(() => _handPreference = value!),
                        items: ['Derecho', 'Zurdo', 'Ambidiestro'].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                            labelText: 'Preferencia de mano'),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Años de experiencia en pádel',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingrese sus años de experiencia';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            yearsOfExperience = int.parse(value!),
                      ),
                      DropdownButtonFormField<String>(
                        value: level,
                        onChanged: (value) => setState(() => level = value!),
                        items: [
                          'Selecciona tú nivel',
                          '0',
                          '0.5',
                          '1.0',
                          '1.5',
                          '2.0',
                          '2.5',
                          '3.0',
                          '3.5',
                          '4.0',
                          '4.5',
                          '5.0',
                          '5.5',
                          '6.0',
                          '7.0'
                        ].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(labelText: 'Nivel'),
                      ),
                      DropdownButtonFormField<String>(
                        value: _positionOnCourt,
                        onChanged: (value) =>
                            setState(() => _positionOnCourt = value!),
                        items: ['Drive', 'Reves'].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                            labelText: 'Preferencia en cancha'),
                      ),
                      DropdownButtonFormField<String>(
                        value: gender,
                        onChanged: (value) => setState(() => gender = value!),
                        items: [
                          'Selecciona tú genero',
                          'Hombre',
                          'Mujer',
                          'Otro'
                        ].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(labelText: 'Genero'),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Tipo de usuario",
                            textAlign: TextAlign.center,
                            // style: GoogleFonts.barlow(
                            //   fontSize: 18.0,
                            //   wordSpacing: 1,
                            //   letterSpacing: 1.2,
                            //   fontWeight: FontWeight.bold,
                            //   color: Colors.black,
                            // ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Jugador",
                                      textAlign: TextAlign.center,
                                      // style: GoogleFonts.barlow(
                                      //   fontSize: 14.0,
                                      //   wordSpacing: 1,
                                      //   letterSpacing: 1,
                                      //   fontWeight: FontWeight.bold,
                                      //   color: Colors.black,
                                      // ),
                                    ),
                                    Checkbox(
                                      value: alumno,
                                      onChanged: (value) {
                                        alumno = value!;

                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Profesor",
                                      textAlign: TextAlign.center,
                                      // style: GoogleFonts.barlow(
                                      //   fontSize: 14.0,
                                      //   wordSpacing: 1,
                                      //   letterSpacing: 1,
                                      //   fontWeight: FontWeight.bold,
                                      //   color: Colors.black,
                                      // ),
                                    ),
                                    Checkbox(
                                      value: choach,
                                      onChanged: (value) {
                                        choach = value!;

                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Preparador",
                                      textAlign: TextAlign.center,
                                      // style: GoogleFonts.barlow(
                                      //   fontSize: 14.0,
                                      //   wordSpacing: 1,
                                      //   letterSpacing: 1,
                                      //   fontWeight: FontWeight.bold,
                                      //   color: Colors.black,
                                      // ),
                                    ),
                                    Checkbox(
                                      value: fisical,
                                      onChanged: (value) {
                                        fisical = value!;

                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'save'.tr,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
