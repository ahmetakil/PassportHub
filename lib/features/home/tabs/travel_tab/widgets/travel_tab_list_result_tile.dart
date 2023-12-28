import 'package:flutter/material.dart';
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
    return HubCountryTile(
      country: country,
      suffix: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: visaRequirementType.color,
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: HubTheme.hubSmallPadding,
              ),
              child: Text(
                visaRequirementType.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
