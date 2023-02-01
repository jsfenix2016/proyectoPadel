import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpadel/Page/Register/Controller/registerController.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerVC = Get.put(RegisterController());
  String email = "";
  String pass = "";
  String confirmPass = "";
  bool terms = false;
  int idtypeuser = 2;
  bool alumno = false;
  bool choach = false;
  bool fisical = false;
  void initPreference() async {}

  int selectTypeUser() {
    if (alumno) {
      idtypeuser = 2;
    } else if (choach) {
      idtypeuser = 1;
    } else if (fisical) {
      idtypeuser = 3;
    }

    return idtypeuser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: const Text('Registro'),
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0, 1),
            colors: <Color>[
              Colors.blue,
              Colors.white,
              Colors.white,
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: 350,
                  height: 550,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0, 1),
                      colors: <Color>[
                        Colors.white,
                        Colors.white,
                        Colors.green,
                      ],
                      tileMode: TileMode.mirror,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3.0,
                          offset: Offset(0.0, 5.0),
                          spreadRadius: 3.0),
                    ],
                  ),
                  child: Column(
                    children: [
                      Center(
                        heightFactor: 0.6,
                        child: SizedBox(
                          child: Image.asset(
                            fit: BoxFit.fill,
                            scale: 0.5,
                            'assets/images/Unknown.png',
                            height: 100,
                            width: 133,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _crearNombre(""),
                      const SizedBox(height: 20),
                      _crearPassword(""),
                      const SizedBox(height: 10),
                      _crearConfirmPassword(''),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Tipo de usuario",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.barlow(
                              fontSize: 18.0,
                              wordSpacing: 1,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Alumno",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.barlow(
                                        fontSize: 14.0,
                                        wordSpacing: 1,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Checkbox(
                                      value: alumno,
                                      onChanged: (value) {
                                        alumno = value!;
                                        choach = false;
                                        fisical = false;
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
                                      style: GoogleFonts.barlow(
                                        fontSize: 14.0,
                                        wordSpacing: 1,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Checkbox(
                                      value: choach,
                                      onChanged: (value) {
                                        choach = value!;
                                        alumno = false;
                                        fisical = false;
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
                                      style: GoogleFonts.barlow(
                                        fontSize: 14.0,
                                        wordSpacing: 1,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Checkbox(
                                      value: fisical,
                                      onChanged: (value) {
                                        fisical = value!;
                                        choach = false;
                                        alumno = false;
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
                      CheckboxListTile(
                        value: terms,
                        onChanged: (value) {
                          terms = value!;
                          setState(() {});
                        },
                        title: Text(
                          "Terminos y condiciones",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.barlow(
                            fontSize: 14.0,
                            wordSpacing: 1,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shadowColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                            ),
                            onPressed: (() {
                              if (!terms) {
                                return;
                              }
                              if (confirmPass != pass) {
                                return;
                              }
                              if (confirmPass == pass && terms) {
                                registerVC.saveRegisterUser(context, email,
                                    pass, terms, selectTypeUser());
                              }
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 32,
                              width: 200,
                              child: const Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
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
      ),
    );
  }

  Widget _crearNombre(String emailtxt) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            email = value;
          },
          style: const TextStyle(color: Colors.black),
          key: Key(emailtxt),
          initialValue: emailtxt,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(50.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1, color: Colors.black), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            hintText: emailtxt,
            labelText: "Email",
            labelStyle: const TextStyle(color: Colors.black),
          ),
          onSaved: (value) => {email = value!},
          validator: (value) {
            return "Email";
          },
        ),
      ),
    );
  }

  Widget _crearPassword(String password) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            pass = value;
          },
          style: const TextStyle(color: Colors.black),
          key: Key(password),
          initialValue: password,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(50.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1, color: Colors.black), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            hintText: password,
            labelText: "Password",
            labelStyle: const TextStyle(color: Colors.black),
          ),
          onSaved: (value) => {pass = value!},
          validator: (value) {
            return "Password";
          },
        ),
      ),
    );
  }

  Widget _crearConfirmPassword(String confirm) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            confirmPass = value;
          },
          style: const TextStyle(color: Colors.black),
          key: Key(confirm),
          initialValue: confirm,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(50.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1, color: Colors.black), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            hintText: confirm,
            labelText: "Confirmar contraseña",
            labelStyle: const TextStyle(color: Colors.black),
          ),
          onSaved: (value) => {confirmPass = value!},
          validator: (value) {
            return "Confirmar contraseña";
          },
        ),
      ),
    );
  }
}
