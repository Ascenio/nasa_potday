import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';

part 'picture_of_the_day_state.dart';

class PictureOfTheDayCubit extends Cubit<PictureOfTheDayState> {
  PictureOfTheDayCubit({required NasaRepository nasaRepository})
      : _nasaRepository = nasaRepository,
        super(const PictureOfTheDayLoading());

  final NasaRepository _nasaRepository;

  Future<void> loadPictureOfTheDay() async {
    emit(const PictureOfTheDayLoading());
    final result = await _nasaRepository.loadInitialPage();
    if (result.pictures.isNotEmpty) {
      emit(PictureOfTheDayLoaded(
        page: result,
        isLoadingMore: false,
      ));
    } else {
      emit(const PictureOfTheDayFailed());
    }
  }

  Future<void> loadNextPage() async {
    final currentState = state as PictureOfTheDayLoaded;
    if (currentState.isLoadingMore) {
      return;
    }
    emit(
      PictureOfTheDayLoaded(
        page: currentState.page,
        isLoadingMore: true,
      ),
    );
    final newPage = await _nasaRepository.loadNextPage(
      currentStartDate: currentState.page.startDate,
    );
    emit(
      PictureOfTheDayLoaded(
        page: currentState.page.merge(newPage),
        isLoadingMore: false,
      ),
    );
  }

  Future<void> searchByText(String text) async {
    emit(const PictureOfTheDayLoading());
    final pictures = await _nasaRepository.searchByText(text);
    emit(
      PictureOfTheDaySearchByText(
        pictures: pictures,
      ),
    );
  }

  Future<void> searchByDate(DateTime date) async {
    emit(const PictureOfTheDayLoading());
    final pictures = await _nasaRepository.searchByDate(date);
    emit(
      PictureOfTheDaySearchByDate(
        pictures: pictures,
      ),
    );
  }
}
