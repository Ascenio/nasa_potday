import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/models/load_picture_of_the_day_request_model.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/models/picture_model.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';

final class RemoteNasaDataSource implements NasaDataSource {
  const RemoteNasaDataSource({
    required this.baseUrl,
    required this.apiKey,
  });

  final String baseUrl;
  final String apiKey;

  @override
  Future<PicturesPageEntity> loadPictureOfTheDay({
    required DateTime startDate,
  }) async {
    try {
      final pictures = await _request(
        LoadPictureOfTheDayRequestModel(
          apiKey: apiKey,
          startDate: startDate,
        ),
      );
      return PicturesPageEntity(
        pictures: pictures,
        startDate: startDate,
      );
    } catch (error) {
      debugPrint('Could not load picture of the day: $error');
    }
    return PicturesPageEntity(
      pictures: [],
      startDate: startDate,
    );
  }

  @override
  Future<PicturesPageEntity> loadNextPage({
    required DateTime currentStartDate,
  }) async {
    final newStartDate = currentStartDate.subtract(const Duration(days: 7));
    try {
      final pictures = await _request(
        LoadPictureOfTheDayRequestModel(
          apiKey: apiKey,
          startDate: newStartDate,
          endDate: currentStartDate.subtract(const Duration(days: 1)),
        ),
      );
      return PicturesPageEntity(pictures: pictures, startDate: newStartDate);
    } catch (error) {
      debugPrint('Could not load picture of the day: $error');
    }
    return PicturesPageEntity(
      pictures: [],
      startDate: newStartDate,
    );
  }

  Future<List<PictureModel>> _request(
      LoadPictureOfTheDayRequestModel request) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: request.toJson(),
    );
    final response = await get(uri);
    return (jsonDecode(response.body) as List)
        .cast<Map<String, dynamic>>()
        .map(PictureModel.fromJson)
        .toList()
        .reversed
        .toList();
  }
}
