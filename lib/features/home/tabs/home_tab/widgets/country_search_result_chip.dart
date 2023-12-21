import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';

class CountrySearchResultChip extends StatelessWidget {
  final Country country;

  const CountrySearchResultChip({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
        color: HubTheme.onPrimary.withOpacity(0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HubCountryFlag(country: country),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(country.iso3code),
            ),
          ],
        ),
      ),
    );
  }
}
