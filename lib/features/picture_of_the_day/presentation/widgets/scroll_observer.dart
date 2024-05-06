import 'package:flutter/material.dart';

class ScrollObserver extends StatelessWidget {
  const ScrollObserver({
    required this.child,
    required this.onScrollEnd,
    this.scrollThreshold = 0.9,
    super.key,
  });

  final double scrollThreshold;
  final VoidCallback onScrollEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final progress = (notification.metrics.pixels /
                  notification.metrics.maxScrollExtent)
              .clamp(0.0, 1.0);
          if (progress >= scrollThreshold) {
            onScrollEnd();
          }
        }
        return false;
      },
      child: child,
    );
  }
}
