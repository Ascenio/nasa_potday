import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/remote_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/repositories/remote_nasa_repository.dart';
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
          nasaRepository: RemoteNasaRepository(
            remoteDatasource: const RemoteNasaDataSource(
              baseUrl: String.fromEnvironment('BASE_URL'),
              apiKey: String.fromEnvironment('API_KEY'),
            ),
          ),
        ),
        child: const PictureOfTheDayPage(),
      ),
    );
  }
}
