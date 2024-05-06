import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';

abstract interface class NasaRepository {
  Future<PictureEntity?> loadPictureOfTheDay();
}
