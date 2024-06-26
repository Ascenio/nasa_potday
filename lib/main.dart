import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_potday/core/clock/system_clock.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/http_remote_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/sqflite_local_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/repositories/caching_nasa_repository.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/cubits/picture_of_the_day/picture_of_the_day_cubit.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/pages/picture_of_the_day_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => PictureOfTheDayCubit(
          nasaRepository: CachingNasaRepository(
            clock: const SystemClock(),
            localDataSource: const SqfliteLocalNasaDataSource(),
            remoteDataSource: const HttpRemoteNasaDataSource(
              baseUrl: String.fromEnvironment('BASE_URL'),
              apiKey: String.fromEnvironment('API_KEY'),
            ),
          ),
        ),
        child: const PictureOfTheDayPage(),
      ),
      theme: ThemeData.from(colorScheme: const ColorScheme.light()),
      darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark()),
    );
  }
}
