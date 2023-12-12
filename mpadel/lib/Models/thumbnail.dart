import 'dart:convert';
import 'dart:typed_data';

Thumbnail userModelFromJson(String str) => Thumbnail.fromJson(json.decode(str));
String userModelToJson(Thumbnail data) => json.encode(data.toJson());

class Thumbnail {
  late String timeMs;
  late Uint8List? imageUrl;
  late String titleThumb;
  late String descriptionThumb;
  late String timeCapture;
  late String timeDurationRecoded;
  late String titleRecoded;
  late String pathRecoded;

  Thumbnail(
      {required this.timeMs,
      required this.imageUrl,
      required this.titleThumb,
      required this.descriptionThumb,
      required this.timeCapture,
      required this.timeDurationRecoded,
      required this.titleRecoded,
      required this.pathRecoded});

  Thumbnail.fromJson(Map<dynamic, dynamic> json)
      : timeMs = json['timeMs'],
        imageUrl = json['imageUrl'],
        titleThumb = json['titleThumb'],
        descriptionThumb = json['descriptionThumb'],
        timeCapture = json['timeCapture'],
        timeDurationRecoded = json['timeDurationRecoded'],
        titleRecoded = json['titleRecoded'],
        pathRecoded = json['pathRecoded'];

  Map<String, dynamic> toJson() => {
        'timeMs': timeMs,
        'imageUrl': imageUrl,
        'titleThumb': titleThumb,
        'descriptionThumb': descriptionThumb,
        'timeCapture': timeCapture,
        'timeDurationRecoded': timeDurationRecoded,
        'titleRecoded': titleRecoded,
        'pathRecoded': pathRecoded,
      };
}
