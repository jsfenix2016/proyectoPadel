import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Klasspadel/Page/Home/Pageview/homeScreen.dart';
import 'package:Klasspadel/Page/Login/Service/loginService.dart';

class LoginController extends GetxController {
  final LoginService loginService = Get.put(LoginService());
  RxBool isloading = false.obs;
  Future<void> saveRegisterUser(
      BuildContext context, String email, String pass) async {
    Map<String, dynamic> req = await loginService.loginMiApi(email, pass);

    if (req['ok'] != null) {
      isloading = false.obs;
      var typeUser = req['typeUser'];
      Get.off(HomePage(
        typeUser: typeUser[0].toString(),
      ));
    } else {
      isloading = false.obs;
      update();
    }
  }
}
