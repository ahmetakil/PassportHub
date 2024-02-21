import 'package:flutter/material.dart';

class CompareEmptyText extends StatelessWidget {
  const CompareEmptyText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Please search 2 countries to compare.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
