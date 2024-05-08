import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';

abstract interface class NasaRepository {
  Future<PicturesPageEntity> loadInitialPage();
  Future<PicturesPageEntity> loadNextPage({
    required DateTime currentStartDate,
  });
  Future<List<PictureEntity>> searchByText(String text);
  Future<List<PictureEntity>> searchByDate(DateTime date);
}
