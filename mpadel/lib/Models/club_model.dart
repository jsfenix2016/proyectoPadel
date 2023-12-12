import 'dart:convert';

ClubModel userModelFromJson(String str) => ClubModel.fromJson(json.decode(str));
String userModelToJson(ClubModel data) => json.encode(data.toJson());

class ClubModel {
  final String idClub;
  final String urlImage;
  final String descriptionClub;

  ClubModel(
      {required this.idClub,
      required this.urlImage,
      required this.descriptionClub});

  ClubModel.fromJson(Map<dynamic, dynamic> json)
      : idClub = json['idClub'],
        urlImage = json['urlImage'],
        descriptionClub = json['descriptionClub'];

  Map<String, dynamic> toJson() => {
        'idClub': idClub,
        'urlImage': urlImage,
        'descriptionClub': descriptionClub
      };
}
