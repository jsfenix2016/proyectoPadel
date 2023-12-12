import 'dart:convert';

UserImageModel userModelFromJson(String str) =>
    UserImageModel.fromJson(json.decode(str));
String userModelToJson(UserImageModel data) => json.encode(data.toJson());

class UserImageModel {
  final String idImage;
  final String idUser;
  final String imagePath;

  UserImageModel({
    required this.idImage,
    required this.idUser,
    required this.imagePath,
  });

  UserImageModel.fromJson(Map<dynamic, dynamic> json)
      : idImage = json['idImage'],
        idUser = json['idUser'],
        imagePath = json['image_path'];

  Map<String, dynamic> toJson() =>
      {'idImage': idImage, 'idUser': idUser, 'image_path': imagePath};
}
