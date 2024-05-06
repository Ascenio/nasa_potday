import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';

part 'picture_of_the_day_state.dart';

class PictureOfTheDayCubit extends Cubit<PictureOfTheDayState> {
  PictureOfTheDayCubit({required NasaRepository nasaRepository})
      : _nasaRepository = nasaRepository,
        super(const PictureOfTheDayLoading());

  final NasaRepository _nasaRepository;

  Future<void> loadPictureOfTheDay() async {
    emit(const PictureOfTheDayLoading());
    final result = await _nasaRepository.loadPictureOfTheDay();
    if (result.isNotEmpty) {
      emit(PictureOfTheDayLoaded(pictures: result));
    } else {
      emit(const PictureOfTheDayFailed());
    }
  }
}
