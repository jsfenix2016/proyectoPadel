import 'dart:convert';

VideoModel userModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));
String userModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  final String idVideo;
  final String urlVideo;
  final String descriptionVideo;

  VideoModel(
      {required this.idVideo,
      required this.urlVideo,
      required this.descriptionVideo});

  VideoModel.fromJson(Map<dynamic, dynamic> json)
      : idVideo = json['idVideo'],
        urlVideo = json['urlVideo'],
        descriptionVideo = json['descriptionVideo'];

  Map<String, dynamic> toJson() => {
        'idVideo': idVideo,
        'urlVideo': urlVideo,
        'descriptionVideo': descriptionVideo
      };
}
