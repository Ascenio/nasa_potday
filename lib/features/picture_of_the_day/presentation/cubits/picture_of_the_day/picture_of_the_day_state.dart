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
        super.props,
        page,
        isLoadingMore,
      ];
}

final class PictureOfTheDaySearch extends PictureOfTheDayState {
  const PictureOfTheDaySearch({
    required this.pictures,
  });

  final List<PictureEntity> pictures;

  @override
  List<Object?> get props => [
        super.props,
        pictures,
      ];
}

final class PictureOfTheDayFailed extends PictureOfTheDayState {
  const PictureOfTheDayFailed();
}
