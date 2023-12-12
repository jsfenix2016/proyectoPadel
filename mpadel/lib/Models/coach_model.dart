import 'dart:convert';

CoachModel userModelFromJson(String str) =>
    CoachModel.fromJson(json.decode(str));
String userModelToJson(CoachModel data) => json.encode(data.toJson());

class CoachModel {
  final String idCoach;
  final String urlImage;
  final String descriptionCoach;

  CoachModel(
      {required this.idCoach,
      required this.urlImage,
      required this.descriptionCoach});

  CoachModel.fromJson(Map<dynamic, dynamic> json)
      : idCoach = json['idCoach'],
        urlImage = json['urlImage'],
        descriptionCoach = json['descriptionCoach'];

  Map<String, dynamic> toJson() => {
        'idCoach': idCoach,
        'urlImage': urlImage,
        'descriptionCoach': descriptionCoach
      };
}
