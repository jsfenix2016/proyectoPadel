import 'package:Klasspadel/Common/decoder_custom.dart';
import 'package:Klasspadel/Common/preferer_user.dart';
import 'package:Klasspadel/Page/Loading/loading_screen.dart';
import 'package:Klasspadel/WidgetsCustom/logo_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Klasspadel/Page/Login/Controller/loginController.dart';
import 'package:Klasspadel/Page/Register/Pageview/register_screen.dart';
import 'package:Klasspadel/WidgetsCustom/textfieldCustom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginVC = Get.put(LoginController());
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _urlApiController;

  PreferenceUser pref = PreferenceUser();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (c) {
        return LoadingIndicator(
          isLoading: c.isloading.value,
          child: Container(
            decoration: decorationCustomWhite(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  const LogoCustomApp(),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 350,
                      height: 500,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment(0, 1),
                          colors: <Color>[
                            Colors.white,
                            Colors.white,
                            Colors.white,
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
                          Text(
                            'titulo_login'.tr,
                            // style: GoogleFonts.barlow(
                            //   fontSize: 24.0,
                            //   wordSpacing: 1,
                            //   letterSpacing: 0.001,
                            //   fontWeight: FontWeight.bold,
                            //   color: Colors.black,
                            // ),
                          ),
                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFieldFormCustomBorder(
                              labelText: "Email",
                              mesaje: "",
                              onChanged: (String value) {
                                _emailController.text = value;
                              },
                              placeholder: "",
                              typeInput: TextInputType.text,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // _crearPassword(""),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFieldFormCustomBorder(
                              labelText: "Password",
                              mesaje: "",
                              onChanged: (String value) {
                                // passtxt = value;
                                _passwordController.text = value;
                              },
                              placeholder: "",
                              typeInput: TextInputType.text,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFieldFormCustomBorder(
                              labelText: "aqui debes colocar la url",
                              mesaje: "",
                              onChanged: (String value) {
                                // passtxt = value;
                                pref.setUrlTemp = value;
                              },
                              placeholder: "",
                              typeInput: TextInputType.text,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            child: Text(
                              'Cambio de contraseña',
                              // style: GoogleFonts.barlow(
                              //   fontSize: 16.0,
                              //   wordSpacing: 1,
                              //   letterSpacing: 0.001,
                              //   fontWeight: FontWeight.normal,
                              //   color: Colors.black,
                              // ),
                            ),
                            onPressed: () => {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Solicitar contraseña",
                                      // style: GoogleFonts.barlow(
                                      //   fontSize: 16.0,
                                      //   wordSpacing: 1,
                                      //   letterSpacing: 0.001,
                                      //   fontWeight: FontWeight.bold,
                                      //   color: Colors.black,
                                      // ),
                                    ),
                                    content: Form(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "Ingrese su email",
                                          // labelStyle: GoogleFonts.barlow(
                                          //   fontSize: 16.0,
                                          //   wordSpacing: 1,
                                          //   letterSpacing: 0.001,
                                          //   fontWeight: FontWeight.normal,
                                          //   color: Colors.black,
                                          // ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shadowColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                        ),
                                        onPressed: (() {
                                          print("object");
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100)),
                                          ),
                                          height: 42,
                                          width: 200,
                                          child: const Center(
                                            child: Text(
                                              'Enviar',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shadowColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                        ),
                                        onPressed: (() {
                                          Navigator.of(context).pop();
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100)),
                                          ),
                                          height: 42,
                                          width: 200,
                                          child: const Center(
                                            child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            },
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
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.transparent,
                                  ),
                                ),
                                onPressed: (() {
                                  setState(() {
                                    c.isloading = true.obs;
                                  });
                                  loginVC.saveRegisterUser(
                                      context,
                                      _emailController.text,
                                      _passwordController.text);
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                  ),
                                  height: 42,
                                  width: 200,
                                  child: const Center(
                                    child: Text(
                                      'Access',
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
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent,
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.transparent,
                                  ),
                                ),
                                onPressed: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()),
                                  );
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                  ),
                                  height: 42,
                                  width: 200,
                                  child: const Center(
                                    child: Text(
                                      'Registrarse',
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
      }),
    );
  }
}
