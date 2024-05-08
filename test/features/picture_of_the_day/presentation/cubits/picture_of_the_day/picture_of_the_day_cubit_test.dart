import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/cubits/picture_of_the_day/picture_of_the_day_cubit.dart';

class NasaRepositoryMock extends Mock implements NasaRepository {}

void main() {
  late NasaRepository nasaRepository;
  late PictureOfTheDayCubit cubit;

  setUp(() {
    nasaRepository = NasaRepositoryMock();
    cubit = PictureOfTheDayCubit(nasaRepository: nasaRepository);
  });

  final currentStartDate = DateTime(2024, 5, 7);
  final pageWithoutPictures = PicturesPageEntity(
    pictures: [],
    startDate: currentStartDate,
  );
  final firstPageWithPictures = PicturesPageEntity(
    pictures: [
      PictureEntity(
        url: Uri.parse(
            'https://apod.nasa.gov/apod/image/2405/BlackHole_Simonnet_960.jpg'),
        explanation: 'some explanation',
        title: 'Black Hole Accreting with Jet',
        date: DateTime(2024, 5, 7),
        isVideo: false,
      ),
    ],
    startDate: currentStartDate,
  );
  final secondPageWithPictures = PicturesPageEntity(
    pictures: [
      PictureEntity(
        url: Uri.parse(
            'https://apod.nasa.gov/apod/image/2405/BlackHole_Simonnet_960.jpg'),
        explanation: 'some explanation',
        title: 'Black Hole Accreting with Jet',
        date: DateTime(2024, 5, 6),
        isVideo: false,
      ),
    ],
    startDate: DateTime(2024, 5, 6),
  );

  blocTest<PictureOfTheDayCubit, PictureOfTheDayState>(
    'emits [PictureOfTheDayLoading, PictureOfTheDayFailed] when no pictures are loaded',
    build: () => cubit,
    setUp: () {
      when(() => nasaRepository.loadInitialPage()).thenAnswer(
        (_) async => pageWithoutPictures,
      );
    },
    act: (cubit) => cubit.loadPictureOfTheDay(),
    expect: () => const <PictureOfTheDayState>[
      PictureOfTheDayLoading(),
      PictureOfTheDayFailed(),
    ],
  );

  blocTest<PictureOfTheDayCubit, PictureOfTheDayState>(
    'emits [PictureOfTheDayLoading, PictureOfTheDayLoaded] when there are pictures loaded',
    build: () => cubit,
    setUp: () {
      when(() => nasaRepository.loadInitialPage()).thenAnswer(
        (_) async => firstPageWithPictures,
      );
    },
    act: (cubit) => cubit.loadPictureOfTheDay(),
    expect: () => <PictureOfTheDayState>[
      const PictureOfTheDayLoading(),
      PictureOfTheDayLoaded(
        page: firstPageWithPictures,
        isLoadingMore: false,
      ),
    ],
  );

  blocTest<PictureOfTheDayCubit, PictureOfTheDayState>(
    'emits [PictureOfTheDayLoaded, PictureOfTheDayLoaded] when it loads more pictures',
    build: () => cubit,
    seed: () => PictureOfTheDayLoaded(
      isLoadingMore: false,
      page: firstPageWithPictures,
    ),
    setUp: () {
      when(() =>
              nasaRepository.loadNextPage(currentStartDate: currentStartDate))
          .thenAnswer(
        (_) async => secondPageWithPictures,
      );
    },
    act: (cubit) => cubit.loadNextPage(),
    expect: () => <PictureOfTheDayState>[
      PictureOfTheDayLoaded(
        page: firstPageWithPictures,
        isLoadingMore: true,
      ),
      PictureOfTheDayLoaded(
        page: firstPageWithPictures.merge(secondPageWithPictures),
        isLoadingMore: false,
      ),
    ],
  );

  final picture = PictureEntity(
    url: Uri.parse('google.com.br/image.jpg'),
    explanation: 'a explanation',
    title: 'Some title',
    date: DateTime(2024, 4, 30),
    isVideo: false,
  );

  blocTest<PictureOfTheDayCubit, PictureOfTheDayState>(
    'emits [PictureOfTheDayLoading, PictureOfTheDaySearchByText] when searching by text',
    build: () => cubit,
    setUp: () {
      when(() => nasaRepository.searchByText('Some')).thenAnswer(
        (_) async => [picture],
      );
    },
    act: (cubit) => cubit.searchByText('Some'),
    expect: () => <PictureOfTheDayState>[
      const PictureOfTheDayLoading(),
      PictureOfTheDaySearchByText(pictures: [picture]),
    ],
  );

  blocTest<PictureOfTheDayCubit, PictureOfTheDayState>(
    'emits [PictureOfTheDayLoading, PictureOfTheDaySearchByText] when searching by date',
    build: () => cubit,
    setUp: () {
      when(() => nasaRepository.searchByDate(DateTime(2024, DateTime.may, 8)))
          .thenAnswer(
        (_) async => [picture],
      );
    },
    act: (cubit) => cubit.searchByDate(DateTime(2024, DateTime.may, 8)),
    expect: () => <PictureOfTheDayState>[
      const PictureOfTheDayLoading(),
      PictureOfTheDaySearchByText(pictures: [picture]),
    ],
  );
}
