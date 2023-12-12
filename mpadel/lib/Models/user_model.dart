import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int idUser;
  final String name;
  final String lastName;

  final String country;
  final String gender;
  final String city;
  final String typeUser;
  final String birthday;
  final String imageProfile;

  UserModel({
    required this.idUser,
    required this.lastName,
    required this.name,
    required this.country,
    required this.gender,
    required this.city,
    required this.typeUser,
    required this.birthday,
    required this.imageProfile,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : idUser = json['idUser'],
        lastName = json['lastName'],
        name = json['name'],
        country = json['country'],
        gender = json['gender'],
        city = json['city'],
        typeUser = json['typeUser'],
        birthday = json['birthday'],
        imageProfile = json['imageProfile'];

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'lastName': lastName,
        'name': name,
        'country': country,
        'gender': gender,
        'city': city,
        'typeUser': typeUser,
        'birthday': birthday,
        'imageProfile': imageProfile
      };
}
