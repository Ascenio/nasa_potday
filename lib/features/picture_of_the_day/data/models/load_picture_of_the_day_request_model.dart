class LoadPictureOfTheDayRequestModel {
  const LoadPictureOfTheDayRequestModel({
    required this.apiKey,
    this.startDate,
    this.endDate,
  });

  final String apiKey;
  final DateTime? startDate;
  final DateTime? endDate;

  Map<String, dynamic> toJson() {
    return {
      'api_key': apiKey,
      if (startDate != null) 'start_date': _dateToString(startDate!),
      if (endDate != null) 'end_date': _dateToString(endDate!),
    };
  }

  String _dateToString(DateTime date) => date.toString().split(' ').first;
}
