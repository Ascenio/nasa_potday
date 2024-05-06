class LoadPictureOfTheDayRequestModel {
  const LoadPictureOfTheDayRequestModel({required this.apiKey});

  final String apiKey;

  Map<String, dynamic> toJson() {
    return {
      'api_key': apiKey,
    };
  }
}
