import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mpadel/Common/constant.dart';

class RegisterService {
//FUNCIONA CORRECTAMENTE
  Future<Map<String, dynamic>> insertRegister(
      String email, String password, bool terms, int typeUser) async {
    try {
      final authData = {
        "email": email,
        "pass": (password),
        //"pass": await ManagerSecurity().encrypte(password),
        "terms": terms,
        "idtypeuser": typeUser
      };
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final resp = await http.post(Uri.parse("${Constant.baseApi}/register"),
          body: json.encode(authData), headers: headers);

      var decodeResp = json.decode(resp.body);

      var reslt = decodeResp;

      if (reslt != null) {
        final algomas = {"ok": true, "token": decodeResp};
        return algomas;
      } else {
        return {"ok": false, "mesaje": decodeResp["error"]["message"]};
      }
    } catch (e) {
      print("catch--------$e");
      return {"ok": true, "token": e};
    }
  }
}
