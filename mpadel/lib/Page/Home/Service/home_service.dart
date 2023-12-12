import 'dart:convert';

import 'package:Klasspadel/Common/constant_api.dart';
import 'package:Klasspadel/Models/player_model.dart';

import 'package:http/http.dart' as http;

class HomeService {
  Future<List<PlayerModel>> getAllPlayer() async {
    return [];
    try {
      final resp = await http.get(
        Uri.parse("${ConstantApi.baseApi}/getplayer"),
      );

      List<dynamic> decodeResp = json.decode(resp.body);
      List<PlayerModel> listPlayer = [];
      for (var element in decodeResp.toList()) {
        PlayerModel player = PlayerModel(
            idUser: element["idUser"],
            name: element["name"].toString(),
            lastName: element["lastname"].toString(),
            country: element["country"].toString(),
            gender: element["gender"].toString(),
            city: element["city"].toString(),
            typeUser: element["typeUser"].toString(),
            birthday: element["birthday"].toString(),
            imageProfile: element["imageProfile"].toString(),
            hand: element["hand"].toString(),
            idPlayer: element["idPlayer"].toString(),
            position: element["positionTrack"].toString(),
            level: element["level"].toString());
        listPlayer.add(player);
      }
      return listPlayer;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<bool?> saveData() async {
    return true;
    // var json = jsonEncode(activityDayApi);

    //  final resp = await http.post(
    //      Uri.parse("${Constant.baseApi}/v1/activity"),
    //      headers: Constant.headers,
    //      body: json
    //  );

    //  if (resp.statusCode == 200) {
    //    return ActivityDayApiResponse.fromJson(jsonDecode(resp.body));
    //  } else {
    //    return null;
    //  }
  }
}
