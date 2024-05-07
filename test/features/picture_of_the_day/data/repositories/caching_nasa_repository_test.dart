import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_potday/core/clock/clock.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/local_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/remote_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/repositories/caching_nasa_repository.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';

class ClockMock extends Mock implements Clock {}

class RemoteNasaDataSourceMock extends Mock implements RemoteNasaDataSource {}

class LocalNasaDataSourceMock extends Mock implements LocalNasaDataSource {}

void main() {
  late Clock clock;
  late RemoteNasaDataSource remoteDataSource;
  late LocalNasaDataSource localDataSource;
  late CachingNasaRepository repository;

  setUp(() {
    clock = ClockMock();
    remoteDataSource = RemoteNasaDataSourceMock();
    localDataSource = LocalNasaDataSourceMock();
    repository = CachingNasaRepository(
      clock: clock,
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  final firstPage = PicturesPageEntity(
    pictures: [
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 5, 7),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 5, 6),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 5, 5),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 5, 4),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 5, 3),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 5, 2),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 5, 1),
        isVideo: false,
      ),
    ],
    startDate: DateTime(2024, 5, 1),
  );
  final secondPage = PicturesPageEntity(
    pictures: [
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 4, 30),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 4, 29),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 4, 28),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 4, 27),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 4, 26),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 4, 25),
        isVideo: false,
      ),
      PictureEntity(
        url: Uri.parse('google.com.br/image.jpg'),
        explanation: 'a explanation',
        title: 'Some title',
        date: DateTime(2024, 4, 24),
        isVideo: false,
      ),
    ],
    startDate: DateTime(2024, 4, 24),
  );
  final remotePage = PicturesPageEntity(
    startDate: firstPage.pictures.take(3).last.date,
    pictures: firstPage.pictures.take(3).toList(),
  );
  final localPage = PicturesPageEntity(
    startDate: firstPage.pictures.skip(3).last.date,
    pictures: firstPage.pictures.skip(3).toList(),
  );

  test(
      'when local storage contains all pictures, should not query remote data source',
      () async {
    final startDate = DateTime(2024, 5, 1);
    final endDate = DateTime(2024, 5, 7);
    when(() => clock.today()).thenReturn(endDate);
    when(
      () => localDataSource.query(
        startDate: startDate,
        endDate: endDate,
      ),
    ).thenAnswer(
      (_) async => firstPage,
    );
    final page = await repository.loadInitialPage();
    expect(page, firstPage);
    verifyZeroInteractions(remoteDataSource);
  });

  test(
      'when local storage contains some pictures, should query the remote data source',
      () async {
    final endDate = DateTime(2024, 5, 7);
    when(() => clock.today()).thenReturn(endDate);
    when(
      () => localDataSource.query(
        startDate: DateTime(2024, 5, 1),
        endDate: endDate,
      ),
    ).thenAnswer(
      (_) async => localPage,
    );
    when(
      () => remoteDataSource.query(
        startDate: DateTime(2024, 5, 5),
        endDate: DateTime(2024, 5, 7),
      ),
    ).thenAnswer(
      (_) async => remotePage,
    );
    when(() => localDataSource.save(remotePage)).thenAnswer((_) async {});
    final page = await repository.loadInitialPage();
    expect(page, firstPage);
  });

  test(
      'when loading the next page should consider 7 days before current start date',
      () async {
    when(
      () => localDataSource.query(
        startDate: DateTime(2024, 4, 24),
        endDate: DateTime(2024, 4, 30),
      ),
    ).thenAnswer(
      (_) async => secondPage,
    );
    final page = await repository.loadNextPage(
      currentStartDate: DateTime(2024, 5, 1),
    );
    expect(page, secondPage);
  });
}
