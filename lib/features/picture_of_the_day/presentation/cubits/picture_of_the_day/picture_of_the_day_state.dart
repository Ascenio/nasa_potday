part of 'picture_of_the_day_cubit.dart';

sealed class PictureOfTheDayState extends Equatable {
  const PictureOfTheDayState();

  @override
  List<Object?> get props => [];
}

final class PictureOfTheDayLoading extends PictureOfTheDayState {
  const PictureOfTheDayLoading();
}

final class PictureOfTheDayLoaded extends PictureOfTheDayState {
  const PictureOfTheDayLoaded({
    required this.page,
    required this.isLoadingMore,
  });

  final PicturesPageEntity page;
  final bool isLoadingMore;

  @override
  List<Object?> get props => [
        page,
        isLoadingMore,
      ];
}

final class PictureOfTheDayFailed extends PictureOfTheDayState {
  const PictureOfTheDayFailed();
}
