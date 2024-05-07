class LoadPictureOfTheDayRequestModel {
  const LoadPictureOfTheDayRequestModel({
    required this.apiKey,
    required this.startDate,
    required this.endDate,
  });

  final String apiKey;
  final DateTime startDate;
  final DateTime endDate;

  Map<String, dynamic> toJson() {
    return {
      'api_key': apiKey,
      'start_date': _dateToString(startDate),
      'end_date': _dateToString(endDate),
    };
  }

  String _dateToString(DateTime date) => date.toString().split(' ').first;
}
