import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HubBackIcon extends StatelessWidget {
  const HubBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
      },
      child: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}
