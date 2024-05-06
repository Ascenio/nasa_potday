part of 'picture_of_the_day_cubit.dart';

sealed class PictureOfTheDayState extends Equatable {
  const PictureOfTheDayState({
    required this.startDate,
  });

  final DateTime startDate;

  @override
  List<Object?> get props => [startDate];
}

final class PictureOfTheDayLoading extends PictureOfTheDayState {
  const PictureOfTheDayLoading({
    required super.startDate,
  });
}

final class PictureOfTheDayLoaded extends PictureOfTheDayState {
  const PictureOfTheDayLoaded({
    required super.startDate,
    required this.pictures,
  });

  final List<PictureEntity> pictures;

  @override
  List<Object?> get props => [super.props, pictures];
}

final class PictureOfTheDayFailed extends PictureOfTheDayState {
  const PictureOfTheDayFailed({
    required super.startDate,
  });
}
