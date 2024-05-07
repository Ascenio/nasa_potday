import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';

abstract interface class NasaRepository {
  Future<PicturesPageEntity> loadInitialPage();

  Future<PicturesPageEntity> loadNextPage({
    required DateTime currentStartDate,
  });
}
