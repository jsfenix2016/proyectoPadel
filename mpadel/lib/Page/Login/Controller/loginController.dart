import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpadel/Page/Login/Service/loginService.dart';

class LoginController extends GetxController {
  final LoginService loginService = Get.put(LoginService());
  Future<void> saveRegisterUser(
      BuildContext context, String email, String pass) async {
    // _prefs.setAceptedSendLocation = senLocation;
    Map<String, dynamic> req = await loginService.loginMiApi(email, pass);
    // mostrarAlerta(context, "Se guardo correctamente");
    if (req['ok'] != null) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Draw()),
      // );
    } else {}
  }
}
