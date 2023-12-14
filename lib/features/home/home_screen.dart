import 'package:flutter/material.dart';
import 'package:passport_hub/common/api/visa_api.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passport Hub"),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Text("List"),
        ],
      ),
    );
  }
}
