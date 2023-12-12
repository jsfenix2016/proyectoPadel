import 'dart:convert';

RecodedModel userModelFromJson(String str) =>
    RecodedModel.fromJson(json.decode(str));
String userModelToJson(RecodedModel data) => json.encode(data.toJson());

class RecodedModel {
  late String timeMs;
  late String titleRecoded;
  late String pathRecoded;

  RecodedModel({
    required this.timeMs,
    required this.titleRecoded,
    required this.pathRecoded,
  });

  RecodedModel.fromJson(Map<dynamic, dynamic> json)
      : timeMs = json['timeMs'],
        titleRecoded = json['titleRecoded'],
        pathRecoded = json['pathRecoded'];

  Map<String, dynamic> toJson() => {
        'timeMs': timeMs,
        'titleRecoded': titleRecoded,
        'pathRecoded': pathRecoded,
      };
}
