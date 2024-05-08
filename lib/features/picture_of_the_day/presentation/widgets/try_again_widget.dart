import 'package:flutter/material.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget({
    required this.onTryAgainPressed,
    super.key,
  });

  final VoidCallback onTryAgainPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: Text('Could not load any pictures')),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTryAgainPressed,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
