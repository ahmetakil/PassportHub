import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

class HubPageTitle extends StatelessWidget {
  final String title;

  const HubPageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: HubTheme.hubMediumPadding,
        top: HubTheme.hubLargePadding,
        bottom: HubTheme.hubMediumPadding,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: HubText.heading,
        ),
      ),
    );
  }
}
