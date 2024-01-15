import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_tile.dart';

class TravelTabListResultTile extends StatelessWidget {
  final Country country;
  final VisaRequirementType visaRequirementType;

  const TravelTabListResultTile({
    super.key,
    required this.country,
    required this.visaRequirementType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HubTheme.hubSmallPadding),
      child: InkWell(
        onTap: () {
          context.pushNamed(
            AppRouter.countryDetails,
            pathParameters: {
              "iso": country.iso3code,
            },
          );
        },
        child: HubCountryTile(
          country: country,
          suffix: Text(
            visaRequirementType.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HubTheme.black.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}
