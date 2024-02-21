import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

class CompareEmptyText extends StatelessWidget {
  const CompareEmptyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: HubTheme.hubMediumPadding,
        horizontal: HubTheme.hubMediumPadding,
      ),
      child: Text(
        'Please select 2 countries to start comparison.',
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
