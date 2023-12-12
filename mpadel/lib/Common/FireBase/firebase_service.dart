import 'dart:convert';

import 'package:Klasspadel/Common/FireBase/firebase_token_api.dart';
import 'package:Klasspadel/Common/constant_api.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  Future<void> saveData(FirebaseTokenApi firebaseTokenApi) async {
    var json = jsonEncode(firebaseTokenApi);

    await http.put(Uri.parse("${ConstantApi.baseApi}/v1/user/fcm"),
        headers: ConstantApi.headers, body: json);
  }
}
