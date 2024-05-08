import 'package:intl/intl.dart';

final class DateFormatter {
  const DateFormatter._();

  static final _yyyyMMddFormat = DateFormat('yyyy-MM-dd');

  static String yyyyMMdd(DateTime date) => _yyyyMMddFormat.format(date);
}
