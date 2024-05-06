import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';

part 'picture_of_the_day_state.dart';

class PictureOfTheDayCubit extends Cubit<PictureOfTheDayState> {
  PictureOfTheDayCubit({required NasaRepository nasaRepository})
      : _nasaRepository = nasaRepository,
        super(
          PictureOfTheDayLoading(
            startDate: DateTime.now().subtract(const Duration(days: 7)),
          ),
        );

  final NasaRepository _nasaRepository;

  Future<void> loadPictureOfTheDay() async {
    emit(PictureOfTheDayLoading(startDate: state.startDate));
    final result = await _nasaRepository.loadPictureOfTheDay(
      startDate: state.startDate,
    );
    if (result.isNotEmpty) {
      emit(PictureOfTheDayLoaded(
        startDate: state.startDate,
        pictures: result,
      ));
    } else {
      emit(PictureOfTheDayFailed(
        startDate: state.startDate,
      ));
    }
  }
}
