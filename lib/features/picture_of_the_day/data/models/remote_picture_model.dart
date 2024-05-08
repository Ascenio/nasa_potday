import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';

class RemotePictureModel extends PictureEntity {
  const RemotePictureModel({
    required super.url,
    required super.title,
    required super.explanation,
    required super.date,
    required super.isVideo,
  });

  factory RemotePictureModel.fromJson(Map<String, dynamic> json) {
    final isVideo = json['media_type'] == 'video';

    return RemotePictureModel(
      url: Uri.parse(isVideo ? json['thumbnail_url'] : json['url']),
      title: json['title'],
      explanation: json['explanation'],
      date: DateTime.parse(json['date']),
      isVideo: isVideo,
    );
  }
}
