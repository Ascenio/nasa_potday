import 'package:nasa_potday/features/picture_of_the_day/data/datasources/remote_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';

class RemoteNasaRepository implements NasaRepository {
  RemoteNasaRepository({
    required this.remoteDatasource,
  });

  final RemoteNasaDataSource remoteDatasource;

  @override
  Future<PicturesPageEntity> loadPictureOfTheDay({
    required DateTime startDate,
  }) {
    return remoteDatasource.loadPictureOfTheDay(startDate: startDate);
  }

  @override
  Future<PicturesPageEntity> loadNextPage({
    required DateTime currentStartDate,
  }) {
    return remoteDatasource.loadNextPage(currentStartDate: currentStartDate);
  }
}
