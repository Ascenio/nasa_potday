import 'package:flutter/foundation.dart';
import 'package:nasa_potday/core/clock/clock.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/local_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/remote_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';

class RemoteNasaRepository implements NasaRepository {
  RemoteNasaRepository({
    required this.clock,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final Clock clock;
  final RemoteNasaDataSource remoteDataSource;
  final LocalNasaDataSource localDataSource;

  static const _defaultPageRange = 7;

  @override
  Future<PicturesPageEntity> loadPictureOfTheDay() async {
    final today = clock.today();
    final localStartDate =
        today.subtract(const Duration(days: _defaultPageRange - 1));
    final localPage = await localDataSource.query(
      startDate: localStartDate,
      endDate: today,
    );
    if (localPage.pictures.length == _defaultPageRange) {
      debugPrint('Only local storage used.');
      return localPage;
    }
    final remoteStartDate =
        localPage.pictures.firstOrNull?.date.add(const Duration(days: 1)) ??
            localStartDate;
    final remotePage = await remoteDataSource.loadPictureOfTheDay(
      startDate: remoteStartDate,
      endDate: today,
    );
    await localDataSource.save(remotePage);
    debugPrint(
      'Took ${localPage.pictures.length} from local storage and ${remotePage.pictures.length} from remote',
    );
    return remotePage.merge(localPage);
  }

  @override
  Future<PicturesPageEntity> loadNextPage({
    required DateTime currentStartDate,
  }) async {
    final remotePage = await remoteDataSource.loadPictureOfTheDay(
      startDate:
          currentStartDate.subtract(const Duration(days: _defaultPageRange)),
      endDate: currentStartDate.subtract(const Duration(days: 1)),
    );
    await localDataSource.save(remotePage);
    return remotePage;
  }
}
