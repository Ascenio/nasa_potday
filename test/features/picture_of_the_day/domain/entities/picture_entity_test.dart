import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';

void main() {
  final entity = PictureEntity(
    url: Uri.parse(
        'https://apod.nasa.gov/apod/image/2405/BlackHole_Simonnet_960.jpg'),
    explanation: 'some explanation',
    title: 'Black Hole Accreting with Jet',
    date: DateTime(2024, 5, 7),
    isVideo: false,
  );
  final similarEntity = PictureEntity(
    url: entity.url,
    explanation: entity.explanation,
    title: entity.title,
    date: entity.date,
    isVideo: entity.isVideo,
  );
  final differentEntity = PictureEntity(
    url: Uri.parse(
        'https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygULcmljayByb2xsZXI%3D'),
    explanation: 'other cool explanation',
    title: 'Dont click the link',
    date: DateTime(2023, 4, 6),
    isVideo: true,
  );

  test('should have equality', () {
    expect(similarEntity, entity);
    expect(differentEntity, isNot(entity));
  });

  test('should have hashCode equality', () {
    expect(similarEntity.hashCode, entity.hashCode);
    expect(differentEntity.hashCode, isNot(entity.hashCode));
  });
}
