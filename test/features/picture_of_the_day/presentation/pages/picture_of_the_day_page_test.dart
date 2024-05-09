import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/cubits/picture_of_the_day/picture_of_the_day_cubit.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/pages/picture_of_the_day_page.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/loading_widget.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/not_found_widget.dart';

class PictureOfTheDayCubitMock extends MockCubit<PictureOfTheDayState>
    implements PictureOfTheDayCubit {}

class NasaRepositoryMock extends Mock implements NasaRepository {}

void main() {
  late PictureOfTheDayCubit cubit;

  setUp(() {
    cubit = PictureOfTheDayCubitMock();
  });

  Future<void> setupPage({
    required WidgetTester tester,
    required List<PictureOfTheDayState> states,
  }) async {
    when(() => cubit.state).thenReturn(const PictureOfTheDayLoading());
    when(() => cubit.stream).thenAnswer((_) => Stream.fromIterable(states));
    when(() => cubit.loadPictureOfTheDay()).thenAnswer((_) async {});
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PictureOfTheDayCubit>.value(
          value: cubit,
          child: const PictureOfTheDayPage(),
        ),
      ),
    );
  }

  final page = PicturesPageEntity(
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
    startDate: DateTime(2024, 5, 7),
  );

  testWidgets('should load the first page', (tester) async {
    await setupPage(tester: tester, states: [
      const PictureOfTheDayLoading(),
      PictureOfTheDayLoaded(page: page, isLoadingMore: false),
    ]);
    expect(find.byType(LoadingWidget), findsOne);
    await tester.pump();
    expect(find.byType(ListView), findsOne);
    verify(() => cubit.loadPictureOfTheDay()).called(1);
  });

  testWidgets('should display TryAgainWidget when cant load the first page',
      (tester) async {
    when(() => cubit.loadPictureOfTheDay()).thenAnswer((_) async {});
    await setupPage(tester: tester, states: [
      const PictureOfTheDayLoading(),
      PictureOfTheDayLoaded(page: page, isLoadingMore: false),
    ]);
    await tester.pump();
    expect(find.byType(ListView), findsOne);
  });

  testWidgets('should display NotFoundWidget when text search has no results',
      (tester) async {
    when(() => cubit.loadPictureOfTheDay()).thenAnswer((_) async {});
    await setupPage(tester: tester, states: [
      const PictureOfTheDayLoading(),
      const PictureOfTheDaySearchByText(pictures: []),
    ]);
    await tester.pump();
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(NotFoundWidget), findsOne);
  });

  testWidgets('should display NotFoundWidget when date search has no results',
      (tester) async {
    when(() => cubit.loadPictureOfTheDay()).thenAnswer((_) async {});
    await setupPage(tester: tester, states: [
      const PictureOfTheDayLoading(),
      const PictureOfTheDaySearchByDate(pictures: []),
    ]);
    await tester.pump();
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(NotFoundWidget), findsOne);
  });
}
