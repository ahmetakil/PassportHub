import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';

class CompareContentSectionTitle extends StatelessWidget {
  final Country left;
  final Country right;
  final String title;

  const CompareContentSectionTitle({
    super.key,
    required this.left,
    required this.right,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HubCountryFlag(
          country: left,
        ),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        HubCountryFlag(
          country: right,
        ),
      ],
    );
  }
}
