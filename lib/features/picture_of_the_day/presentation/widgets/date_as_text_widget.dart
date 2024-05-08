import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DateAsTextWidget extends StatelessWidget {
  const DateAsTextWidget({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Text(DateFormat('dd/MM/yyyy').format(date));
  }
}
