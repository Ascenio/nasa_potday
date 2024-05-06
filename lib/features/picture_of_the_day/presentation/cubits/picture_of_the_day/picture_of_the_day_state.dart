part of 'picture_of_the_day_cubit.dart';

sealed class PictureOfTheDayState extends Equatable {
  const PictureOfTheDayState({
    required this.startDate,
  });

  final DateTime startDate;

  @override
  List<Object?> get props => [
        startDate,
      ];
}

final class PictureOfTheDayLoading extends PictureOfTheDayState {
  PictureOfTheDayLoading()
      : super(
          startDate: DateTime.now().subtract(const Duration(days: 7)),
        );
}

final class PictureOfTheDayLoaded extends PictureOfTheDayState {
  const PictureOfTheDayLoaded({
    required super.startDate,
    required this.pictures,
    required this.isLoadingMore,
  });

  final List<PictureEntity> pictures;
  final bool isLoadingMore;

  @override
  List<Object?> get props => [
        super.props,
        pictures,
        isLoadingMore,
      ];
}

final class PictureOfTheDayFailed extends PictureOfTheDayState {
  const PictureOfTheDayFailed({
    required super.startDate,
  });
}
