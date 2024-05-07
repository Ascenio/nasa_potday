import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_potday/core/clock/system_clock.dart';

void main() {
  test('should be equivalent to DateTime.now, but without hour information',
      () {
    const clock = SystemClock();
    final today = clock.today();
    final now = DateTime.now();
    expect(today, DateTime(now.year, now.month, now.day));
  });
}
