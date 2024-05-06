import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';

class PictureModel extends PictureEntity {
  const PictureModel({
    required super.url,
    required super.title,
    required super.date,
    required super.isVideo,
  });

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    final url = Uri.parse(json['url']);

    return PictureModel(
      url: url,
      title: json['title'],
      date: DateTime.parse(json['date']),
      isVideo: url.host == 'www.youtube.com',
    );
  }
}
