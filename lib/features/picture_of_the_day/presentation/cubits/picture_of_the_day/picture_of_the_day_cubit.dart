import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';

part 'picture_of_the_day_state.dart';

class PictureOfTheDayCubit extends Cubit<PictureOfTheDayState> {
  PictureOfTheDayCubit({required NasaRepository nasaRepository})
      : _nasaRepository = nasaRepository,
        super(PictureOfTheDayLoading());

  final NasaRepository _nasaRepository;

  Future<void> loadPictureOfTheDay() async {
    emit(PictureOfTheDayLoading());
    final result = await _nasaRepository.loadPictureOfTheDay(
      startDate: state.startDate,
    );
    if (result.pictures.isNotEmpty) {
      emit(PictureOfTheDayLoaded(
        startDate: state.startDate,
        pictures: result.pictures,
        isLoadingMore: false,
      ));
    } else {
      emit(PictureOfTheDayFailed(
        startDate: state.startDate,
      ));
    }
  }

  Future<void> loadNextPage() async {
    final currentState = state as PictureOfTheDayLoaded;
    if (currentState.isLoadingMore) {
      return;
    }
    emit(
      PictureOfTheDayLoaded(
        startDate: currentState.startDate,
        pictures: currentState.pictures,
        isLoadingMore: true,
      ),
    );
    final newPage = await _nasaRepository.loadNextPage(
      currentStartDate: state.startDate,
    );
    emit(PictureOfTheDayLoaded(
      startDate: newPage.startDate,
      pictures: [
        ...currentState.pictures,
        ...newPage.pictures,
      ],
      isLoadingMore: false,
    ));
  }
}
