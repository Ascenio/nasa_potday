import 'clock.dart';

final class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
