import 'package:flutter/foundation.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';

class PicturesPageEntity {
  PicturesPageEntity({
    required this.pictures,
    required this.startDate,
  });

  final List<PictureEntity> pictures;
  final DateTime startDate;

  PicturesPageEntity merge(
    PicturesPageEntity another,
  ) {
    return PicturesPageEntity(
      startDate: another.startDate,
      pictures: [
        ...pictures,
        ...another.pictures,
      ],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PicturesPageEntity &&
        other.startDate == startDate &&
        listEquals(other.pictures, pictures);
  }

  @override
  int get hashCode => startDate.hashCode ^ Object.hashAll(pictures);
}
