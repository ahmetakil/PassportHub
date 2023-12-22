import 'package:flutter/material.dart';

class HubLoading extends StatelessWidget {
  const HubLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
