import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';

class CountrySearchResultRow extends StatelessWidget {
  final Country country;
  final bool isSelected;

  const CountrySearchResultRow({
    super.key,
    required this.country,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            HubTheme.hubSmallPadding,
          ),
          child: Row(
            children: [
              HubCountryFlag(
                country: country,
              ),
              Padding(
                padding: const EdgeInsets.only(left: HubTheme.hubSmallPadding),
                child: Text(country.name ?? country.iso3code),
              ),
              const Spacer(),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(
                    right: HubTheme.hubSmallPadding,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}