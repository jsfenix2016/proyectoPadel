import 'package:Klasspadel/Models/user_model.dart';

class PlayerModel extends UserModel {
  String hand;
  String idPlayer;
  String position;
  String level;

  PlayerModel(
      {required super.idUser,
      required super.lastName,
      required super.name,
      required super.country,
      required super.gender,
      required super.city,
      required super.typeUser,
      required super.birthday,
      required super.imageProfile,
      required this.hand,
      required this.idPlayer,
      required this.position,
      required this.level});

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> baseJson = super.toJson();
    return {
      ...baseJson,
      'hand': hand,
      'idPlayer': idPlayer,
      'position': position,
      'level': level
    };
  }
}
