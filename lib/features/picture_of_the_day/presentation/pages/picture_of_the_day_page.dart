import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/cubits/picture_of_the_day/picture_of_the_day_cubit.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/loading_widget.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/not_found_widget.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/picture_widget.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/scroll_observer.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/search_app_bar.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/try_again_widget.dart';

class PictureOfTheDayPage extends StatefulWidget {
  const PictureOfTheDayPage({
    super.key,
  });

  @override
  State<PictureOfTheDayPage> createState() => _PictureOfTheDayPageState();
}

class _PictureOfTheDayPageState extends State<PictureOfTheDayPage> {
  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() {
    return context.read<PictureOfTheDayCubit>().loadPictureOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        onReset: refresh,
        onTextSearch: (text) {
          context.read<PictureOfTheDayCubit>().searchByText(text);
        },
        onDateSearch: (date) {
          context.read<PictureOfTheDayCubit>().searchByDate(date);
        },
      ),
      body: BlocBuilder<PictureOfTheDayCubit, PictureOfTheDayState>(
        builder: (context, state) {
          return switch (state) {
            PictureOfTheDayLoading() => const LoadingWidget(),
            PictureOfTheDayLoaded(:final isLoadingMore) =>
              RefreshIndicator.adaptive(
                onRefresh: refresh,
                child: ScrollObserver(
                  onScrollEnd: () {
                    context.read<PictureOfTheDayCubit>().loadNextPage();
                  },
                  child: Builder(
                    builder: (_) {
                      final itemCount =
                          state.page.pictures.length + (isLoadingMore ? 1 : 0);
                      return ListView.separated(
                        itemBuilder: (_, index) {
                          final isLast = index == itemCount - 1;
                          if (isLast && isLoadingMore) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: LoadingWidget(),
                            );
                          }
                          return PictureWidget(
                              picture: state.page.pictures[index]);
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 32),
                        itemCount: itemCount,
                      );
                    },
                  ),
                ),
              ),
            PictureOfTheDayFailed() => TryAgainWidget(
                onTryAgainPressed: refresh,
              ),
            PictureOfTheDaySearch() => state.pictures.isEmpty
                ? const NotFoundWidget()
                : ListView.separated(
                    itemBuilder: (_, index) {
                      return PictureWidget(picture: state.pictures[index]);
                    },
                    itemCount: state.pictures.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 32),
                  ),
          };
        },
      ),
    );
  }
}
