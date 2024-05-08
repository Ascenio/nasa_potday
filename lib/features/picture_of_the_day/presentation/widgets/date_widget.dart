import 'package:flutter/material.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/date_as_text_widget.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    required this.date,
    super.key,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_month_outlined),
        const SizedBox(width: 8),
        DateAsTextWidget(date: date)
      ],
    );
  }
}
