part of 'picture_of_the_day_cubit.dart';

sealed class PictureOfTheDayState {
  const PictureOfTheDayState();
}

final class PictureOfTheDayLoading extends PictureOfTheDayState {
  const PictureOfTheDayLoading();
}

final class PictureOfTheDayLoaded extends PictureOfTheDayState {
  const PictureOfTheDayLoaded({required this.pictures});

  final List<PictureEntity> pictures;
}

final class PictureOfTheDayFailed extends PictureOfTheDayState {
  const PictureOfTheDayFailed();
}
