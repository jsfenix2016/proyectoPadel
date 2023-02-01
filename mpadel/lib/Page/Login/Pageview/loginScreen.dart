import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpadel/Page/Login/Controller/loginController.dart';
import 'package:mpadel/Page/Register/Pageview/registerScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginVC = Get.put(LoginController());
  String emailtxt = "";
  String passtxt = "";
  void initPreference() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Stack(
          children: <Widget>[
            // _loginForm(context),
            // SafeArea(
            //   child: Container(
            //     height: 180.0,
            //   ),
            // ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: 300,
                height: 500,
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
                      heightFactor: 1,
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
                    const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    _crearNombre(""),
                    const SizedBox(height: 10),
                    _crearPassword(""),
                    const SizedBox(height: 10),
                    TextButton(
                      child: const Text('Cambio de contraseña'),
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Ingresar"),
                              content: Form(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Ingrese su nombre",
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
                                  onPressed: (() {}),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      borderRadius: const BorderRadius.all(
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
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      borderRadius: const BorderRadius.all(
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
                    const SizedBox(height: 20),
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
                            loginVC.saveRegisterUser(
                                context, emailtxt, passtxt);
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent,
                            ),
                          ),
                          onPressed: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
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
            TextButton(
              child: const Text('new_user'),
              onPressed: () => {},
            ),
            const SizedBox(
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _crearNombre(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            emailtxt = value;
          },
          style: const TextStyle(color: Colors.black),
          key: Key(name),
          initialValue: name,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(100.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1, color: Colors.black), //<-- SEE HERE
              borderRadius: BorderRadius.circular(100.0),
            ),
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            hintText: name,
            labelText: " Constant.nameUser",
            labelStyle: const TextStyle(color: Colors.black),
          ),
          onSaved: (value) => {},
          validator: (value) {
            return "Constant.namePlaceholder";
          },
        ),
      ),
    );
  }

  Widget _crearPassword(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            passtxt = value;
          },
          style: const TextStyle(color: Colors.black),
          key: Key(name),
          initialValue: name,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(100.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1, color: Colors.black), //<-- SEE HERE
              borderRadius: BorderRadius.circular(100.0),
            ),
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            hintText: name,
            labelText: "Constant.password",
            labelStyle: const TextStyle(color: Colors.black),
          ),
          onSaved: (value) => {},
          validator: (value) {
            return "Constant.namePlaceholder";
          },
        ),
      ),
    );
  }

  Widget get dogImage {
    return Container(
      // You can explicitly set heights and widths on Containers.
      // Otherwise they take up as much space as their children.
      width: 100.0,
      height: 100.0,
      // Decoration is a property that lets you style the container.
      // It expects a BoxDecoration.
      decoration: const BoxDecoration(
        // BoxDecorations have many possible properties.
        // Using BoxShape with a background image is the
        // easiest way to make a circle cropped avatar style image.
        shape: BoxShape.circle,
        image: DecorationImage(
          // Just like CSS's `imagesize` property.
          fit: BoxFit.cover,
          // A NetworkImage widget is a widget that
          // takes a URL to an image.
          // ImageProviders (such as NetworkImage) are ideal
          // when your image needs to be loaded or can change.
          // Use the null check to avoid an error.
          image: AssetImage("assets/images/iconPets.png"),
        ),
      ),
    );
  }
}
