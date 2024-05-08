import 'package:intl/intl.dart';

final class DateFormatter {
  const DateFormatter._();

  static final _yyyyMMddFormat = DateFormat('yyyy-MM-dd');
  static final _ddMMyyyy = DateFormat('dd/MM/yyyy');

  static String yyyyMMdd(DateTime date) => _yyyyMMddFormat.format(date);
  static String ddMMyyyy(DateTime date) => _ddMMyyyy.format(date);
}
