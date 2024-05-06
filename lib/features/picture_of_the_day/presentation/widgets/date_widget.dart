import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        Text(DateFormat('dd/MM/yyyy').format(date)),
      ],
    );
  }
}
