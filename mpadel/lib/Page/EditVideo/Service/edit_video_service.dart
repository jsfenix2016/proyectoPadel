import 'dart:io';
import 'dart:typed_data';

import 'package:Klasspadel/Common/preferer_user.dart';
import 'package:Klasspadel/Models/thumbnail.dart';

import 'package:Klasspadel/Models/videobd.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:Klasspadel/Common/constant_api.dart';

class EditVideoService {
  PreferenceUser pref = PreferenceUser();
//FUNCIONA CORRECTAMENTE
  //final encrip = new ManagerSecurity();
  Future<Map<String, dynamic>> saveVideo(VideoBD video, int user) async {
    final File convertedFile = File(video.urlVideo);
    // final Uint8List videoBytes = await convertedFile.readAsBytes();
    String img64 = base64Encode(video.imgage);
    String video64 = base64Encode(convertedFile.readAsBytesSync());
    List<Thumbnail> list = [];

    for (var element in video.listThumbnail) {
      String base64String = base64Encode(element.imageUrl);
      Thumbnail modelo = Thumbnail(
          timeMs: element.timeMs.toString(),
          imageUrl: element.imageUrl,
          titleThumb: element.titleThumb,
          descriptionThumb: element.descriptionThumb,
          timeCapture: element.timeCapture.toString(),
          timeDurationRecoded: '',
          titleRecoded: '',
          pathRecoded: '');

      list.add(modelo);
    }

    final authData = {
      "imgName": video.title,
      "idUser": user,
      "idOtherUser": user,
      "thumbnail": (img64),
      "video": video64,
      "listThumbnail": list,
    };
    var urltemp = "";
    if (pref.getUrlTemp != "") {
      urltemp = pref.getUrlTemp;
    } else {
      urltemp = ConstantApi.baseApi;
    }

    try {
      final resp = await http.post(Uri.parse("$urltemp/video"),
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
      return {"ok": false, "mesaje": error.toString()};
    }
  }
}
