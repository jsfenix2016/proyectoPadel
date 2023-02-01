import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mpadel/Common/constant.dart';

class LoginService {
//FUNCIONA CORRECTAMENTE
  //final encrip = new ManagerSecurity();
  Future<Map<String, dynamic>> loginMiApi(String email, String password) async {
    final authData = {"email": email, "pass": (password)};

    try {
      final resp = await http.post(Uri.parse("${Constant.baseApi}/login/"),
          body: json.encode(authData));

      Map<String, dynamic> decodeResp = json.decode(resp.body);

      if (decodeResp['idUser'] == null) {
        return {"ok": false, "mesaje": "error"};
      }
      // var reslt = decodeResp['idUser'];

      if (decodeResp['idUser'] != null) {
        return {"ok": true, "token": decodeResp['idUser']};
      } else {
        return {"ok": false, "mesaje": decodeResp['idUser']};
      }
    } catch (error) {
      // print(error.toString());
      return {"ko": false, "mesaje": error.toString()};
    }
  }
}
