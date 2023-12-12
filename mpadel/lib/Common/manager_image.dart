import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:Klasspadel/Models/user_images_model.dart';
import 'package:path/path.dart';

class ManagerImage {
  JsonCodec codec = const JsonCodec();

  Future<String> saveImage(Map data) async {
    try {
      var imgName = data['imgName'];
      var typeImg = data['typeImg'];
      var idUser = data['idUser'];
      var img = data['img'];

      Uint8List bytesImage;
      bytesImage = const Base64Decoder().convert(img);
      final myDir2 = Directory('dir/$typeImg/$idUser/');
      final file = File(join(myDir2.uri.path, '$imgName.png'));

      await file.exists().then((isThere) {
        isThere
            ? print('')
            : Directory('dir/$typeImg/$idUser/').createSync(recursive: true);
      });
      file.writeAsBytesSync(bytesImage, mode: FileMode.append);

      var imgUser = UserImageModel(
          idImage: imgName, idUser: idUser, imagePath: file.uri.toString());

      return "";
    } catch (e) {
      return "error: $e";
    }
  }
}
