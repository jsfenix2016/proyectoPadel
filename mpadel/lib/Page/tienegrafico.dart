import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Klasspadel/Page/UserData/linearchart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:image_picker/image_picker.dart';
import 'package:Klasspadel/Models/userbd.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({super.key});

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  late int _age;
  String _handPreference = 'Derecho';
  late int _yearsOfExperience;
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
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(
              Radius.circular(50.0) //                 <--- border radius here
              ),
          border: Border.all(color: Colors.blueAccent),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: pinned,
            snap: snap,
            floating: floating,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: _mostrarFoto(),
                  // ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Text(
                                      '24k',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    'Followers',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.amber, Colors.green],
                                    stops: [0, 1],
                                    begin: AlignmentDirectional(1, -1),
                                    end: AlignmentDirectional(-1, 1),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 4, 4),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(4, 4, 4, 4),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: _mostrarFoto(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 12),
                                      child: Text(
                                        '152',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      textAlign: TextAlign.center,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Text(
                            'David Jerome',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                          child: Text(
                            'David.j@gmail.com',
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                          child: Text(
                            'I exist to design pixels, beyond that my life is void and meaningless... i\'m just kidding I live to make other peoples lives easier.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 44, 0, 0),
                            child: Container(
                              width: double.infinity,
                              height: 400,
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0x33000000),
                                    offset: Offset(0, -1),
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16, 16, 16, 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'My Stats',
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, 0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 16, 0, 0),
                                              child: Wrap(
                                                spacing: 16,
                                                runSpacing: 16,
                                                alignment: WrapAlignment.start,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                direction: Axis.horizontal,
                                                runAlignment:
                                                    WrapAlignment.start,
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    height: 160,
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              12, 12, 12, 12),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .supervisor_account_rounded,
                                                            color: Colors.amber,
                                                            size: 44,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        12,
                                                                        0,
                                                                        4),
                                                            child: Text(
                                                              '56.4k',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Customers',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    height: 160,
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              12, 12, 12, 12),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .supervisor_account_rounded,
                                                            color: Colors.amber,
                                                            size: 44,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        12,
                                                                        0,
                                                                        4),
                                                            child: Text(
                                                              '56.4k',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Customers',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    height: 160,
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              12, 12, 12, 12),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .supervisor_account_rounded,
                                                            color: Colors.amber,
                                                            size: 44,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        12,
                                                                        0,
                                                                        4),
                                                            child: Text(
                                                              '56.4k',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Customers',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    height: 160,
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              12, 12, 12, 12),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .supervisor_account_rounded,
                                                            color: Colors.amber,
                                                            size: 44,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        12,
                                                                        0,
                                                                        4),
                                                            child: Text(
                                                              '56.4k',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Customers',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Generated code for this Column Widget...

                  // if (_profilePicture != null)
                  //   Image.file(
                  //     _profilePicture,
                  //     fit: BoxFit.cover,
                  //   ),
                  // if (_profilePicture == null)
                  //   Image.asset(
                  //     'assets/images/images.jpeg',
                  //     fit: BoxFit.cover,
                  //   ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  getImageGallery(ImageSource.camera);
                },
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const LineChartSample2(),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Nombre'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su nombre';
                            }
                            return null;
                          },
                          onSaved: (value) => _firstName = value!,
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
                          onSaved: (value) => _lastName = value!,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Edad'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su edad';
                            }
                            return null;
                          },
                          onSaved: (value) => _age = int.parse(value!),
                        ),
                        DropdownButtonFormField<String>(
                          value: _handPreference,
                          onChanged: (value) =>
                              setState(() => _handPreference = value!),
                          items:
                              ['Derecho', 'Zurdo', 'Ambidiestro'].map((value) {
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
                              _yearsOfExperience = int.parse(value!),
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
                          decoration: InputDecoration(
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
                          decoration:
                              const InputDecoration(labelText: 'Genero'),
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
                              // TODO: Guardar los datos en una base de datos o enviarlos a un servidor
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
