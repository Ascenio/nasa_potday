import 'package:nasa_potday/core/date_formatters/date_formatter.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';

class LocalPictureModel extends PictureEntity {
  const LocalPictureModel({
    required super.url,
    required super.title,
    required super.explanation,
    required super.date,
    required super.isVideo,
  });

  factory LocalPictureModel.fromEntity(PictureEntity entity) {
    return LocalPictureModel(
      url: entity.url,
      title: entity.title,
      explanation: entity.explanation,
      date: entity.date,
      isVideo: entity.isVideo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': DateFormatter.yyyyMMdd(date),
      'url': url.toString(),
      'title': title,
      'explanation': explanation,
      'is_video': isVideo ? 1 : 0,
    };
  }

  factory LocalPictureModel.fromJson(Map<String, dynamic> json) {
    final isVideo = json['media_type'] == 'video';

    return LocalPictureModel(
      url: Uri.parse(isVideo ? json['thumbnail_url'] : json['url']),
      title: json['title'],
      explanation: json['explanation'],
      date: DateTime.parse(json['date']),
      isVideo: json['is_video'] == 1,
    );
  }
}
