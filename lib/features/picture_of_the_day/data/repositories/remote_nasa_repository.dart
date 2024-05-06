import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/models/picture_model.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/repositories/nasa_repository.dart';

class RemoteNasaRepository implements NasaRepository {
  RemoteNasaRepository({
    required this.baseUrl,
    required this.apiKey,
  });

  final String baseUrl;
  final String apiKey;

  @override
  Future<PictureEntity?> loadPictureOfTheDay() async {
    try {
      final uri = Uri.parse('$baseUrl?api_key=$apiKey');
      final response = await get(uri);
      final json = jsonDecode(response.body);
      return PictureModel.fromJson(json);
    } catch (error) {
      debugPrint('Could not load picture of the day: $error');
    }
    return null;
  }
}
