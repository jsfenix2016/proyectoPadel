import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:Klasspadel/Common/constant_api.dart';
import 'package:Klasspadel/Models/register_model.dart';
import 'package:uuid/uuid.dart';

class RegisterService {
//FUNCIONA CORRECTAMENTE
  Future<Map<String, dynamic>> insertRegister(
      UserRegisterModel userModel) async {
    try {
      final authData = {
        "email": userModel.email,
        "pass": (userModel.pass),
        //"pass": await ManagerSecurity().encrypte(password),
        "terms": userModel.terms,
        "typeuser": userModel.typeUser,
        "uuid": const Uuid().v1(),
      };
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final resp = await http.post(Uri.parse("${ConstantApi.baseApi}/register"),
          body: json.encode(authData), headers: headers);

      var decodeResp = json.decode(resp.body);

      var reslt = decodeResp;

      if (reslt != null) {
        final algomas = {"ok": true, "token": decodeResp};
        return algomas;
      } else {
        return {"ko": false, "mesaje": decodeResp["error"]["message"]};
      }
    } catch (e) {
      return {"ko": true, "token": e};
    }
  }
}
