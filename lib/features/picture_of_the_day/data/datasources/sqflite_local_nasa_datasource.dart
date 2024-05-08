import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nasa_potday/core/date_formatters/date_formatter.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/datasources/local_nasa_datasource.dart';
import 'package:nasa_potday/features/picture_of_the_day/data/models/local_picture_model.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/pictures_page_entity.dart';
import 'package:sqflite/sqflite.dart';

final class SqfliteLocalNasaDataSource implements LocalNasaDataSource {
  const SqfliteLocalNasaDataSource();

  static const _picturesTable = 'pictures';

  Future<Database> _initialize() async {
    final database = await openDatabase(
      'database.db',
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
CREATE TABLE $_picturesTable ( 
  'date' TEXT PRIMARY KEY, 
  url TEXT, 
  title TEXT, 
  explanation TEXT,
  is_video INTEGER
)
''');
      },
    );
    return database;
  }

  @override
  Future<void> save(PicturesPageEntity page) async {
    try {
      final database = await _initialize();
      final batch = database.batch();
      for (final picture in page.pictures) {
        database.insert(
          _picturesTable,
          LocalPictureModel.fromEntity(picture).toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    } on DatabaseException catch (error) {
      debugPrint('Could not save page ${page.startDate}: $error');
    }
  }

  @override
  Future<PicturesPageEntity> query({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final database = await _initialize();
      final pictures = await database.query(
        _picturesTable,
        where: 'DATE(date) BETWEEN ? AND ?',
        orderBy: 'DATE(date) DESC',
        whereArgs: [
          DateFormatter.yyyyMMdd(startDate),
          DateFormatter.yyyyMMdd(endDate),
        ],
      );
      return PicturesPageEntity(
        startDate: startDate,
        pictures: pictures.map(LocalPictureModel.fromJson).toList(),
      );
    } on DatabaseException catch (error) {
      debugPrint('Could not load page $startDate: $error');
    }
    return PicturesPageEntity(
      startDate: startDate,
      pictures: [],
    );
  }

  @override
  Future<List<PictureEntity>> search({
    required String title,
  }) async {
    try {
      final database = await _initialize();
      final result = await database.query(
        _picturesTable,
        where: r"UPPER(title) LIKE UPPER(?)",
        whereArgs: ['%$title%'],
        orderBy: 'DATE(date) DESC',
      );
      return result.map(LocalPictureModel.fromJson).toList();
    } on DatabaseException catch (error) {
      debugPrint('Could not search for "$title": $error');
    }
    return [];
  }
}
