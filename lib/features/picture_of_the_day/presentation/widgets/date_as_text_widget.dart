import 'package:flutter/widgets.dart';
import 'package:nasa_potday/core/date_formatters/date_formatter.dart';

class DateAsTextWidget extends StatelessWidget {
  const DateAsTextWidget({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Text(DateFormatter.ddMMyyyy(date));
  }
}
