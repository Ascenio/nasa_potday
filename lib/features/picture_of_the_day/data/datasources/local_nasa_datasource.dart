import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';

abstract interface class LocalNasaDataSource {
  Future<void> save(PicturesPageEntity page);
  Future<PicturesPageEntity> query({
    required DateTime startDate,
    required DateTime endDate,
  });
}
