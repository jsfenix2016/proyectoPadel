import 'package:Klasspadel/Common/preferer_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:Klasspadel/Common/constant_api.dart';

class LoginService {
  PreferenceUser pref = PreferenceUser();
//FUNCIONA CORRECTAMENTE
  //final encrip = new ManagerSecurity();
  Future<Map<String, dynamic>> loginMiApi(String email, String password) async {
    final authData = {"email": email, "pass": (password)};
    var urltemp = "";
    if (pref.getUrlTemp != "") {
      urltemp = pref.getUrlTemp;
    } else {
      urltemp = ConstantApi.baseApi;
    }

    try {
      final resp = await http.post(Uri.parse("$urltemp/login/"),
          body: json.encode(authData));

      Map<String, dynamic> decodeResp = json.decode(resp.body);

      if (decodeResp['idUser'] == null) {
        return {"ok": false, "mesaje": "error"};
      }

      if (decodeResp['idUser'] != null) {
        return {
          "ok": true,
          "idUser": decodeResp['idUser'],
          "typeUser": decodeResp['typeUser']
        };
      } else {
        return {"ok": false, "mesaje": decodeResp['idUser']};
      }
    } catch (error) {
      // print(error.toString());
      return {"ko": false, "mesaje": error.toString()};
    }
  }
}
