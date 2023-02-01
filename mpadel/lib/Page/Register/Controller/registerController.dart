import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpadel/Page/Login/Pageview/loginScreen.dart';
import 'package:mpadel/Page/Register/Service/registerService.dart';

// final _prefs = PreferenceUser();

class RegisterController extends GetxController {
  final RegisterService registerService = Get.put(RegisterService());
  Future<void> saveRegisterUser(BuildContext context, String email, String pass,
      bool terms, int typeUser) async {
    // _prefs.setAceptedSendLocation = senLocation;
    Map<String, dynamic> req =
        await registerService.insertRegister(email, pass, terms, typeUser);
    // mostrarAlerta(context, "Se guardo correctamente");
    if (req['ok'] != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {}
  }
}
