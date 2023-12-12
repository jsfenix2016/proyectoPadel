import 'dart:convert';

RolModel userModelFromJson(String str) => RolModel.fromJson(json.decode(str));
String userModelToJson(RolModel data) => json.encode(data.toJson());

class RolModel {
  final int idRol;

  RolModel({required this.idRol});

  RolModel.fromJson(Map<dynamic, dynamic> json) : idRol = json['idRol'];

  Map<String, dynamic> toJson() => {'idRol': idRol};
}
