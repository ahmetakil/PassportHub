import 'package:flutter/material.dart';

class HubDivider extends StatelessWidget {
  const HubDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      color: Colors.grey.withOpacity(
        0.5,
      ),
    );
  }
}
