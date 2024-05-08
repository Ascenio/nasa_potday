import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            "Didn't find any results.",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text("Perhaps you could try a different search?"),
        ],
      ),
    );
  }
}
