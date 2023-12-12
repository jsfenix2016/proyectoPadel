import 'dart:convert';

UserRegisterModel userModelFromJson(String str) =>
    UserRegisterModel.fromJson(json.decode(str));
String userModelToJson(UserRegisterModel data) => json.encode(data.toJson());

class UserRegisterModel {
  late String email;
  late String pass;
  late bool terms;
  late String typeUser;
  late String dateRegister;
  late String uuid;

  UserRegisterModel(
      {required this.email,
      required this.pass,
      required this.terms,
      required this.typeUser,
      this.dateRegister = "",
      this.uuid = ""});

  UserRegisterModel.fromJson(Map<dynamic, dynamic> json)
      : email = json['email'],
        pass = json['pass'],
        terms = json['terms'],
        dateRegister = json['dateRegister'],
        typeUser = json['typeUser'],
        uuid = json['uuid'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'pass': pass,
        'terms': terms,
        'typeUser': typeUser,
        'dateRegister': dateRegister,
        'uuid': uuid,
      };
}
