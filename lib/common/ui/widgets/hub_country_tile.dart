import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';

class HubCountryTile extends StatelessWidget {
  final Country country;
  final Widget? suffix;
  final EdgeInsets padding;

  const HubCountryTile({
    super.key,
    required this.country,
    this.suffix,
    this.padding = const EdgeInsets.all(
      HubTheme.hubSmallPadding,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            HubCountryFlag(
              country: country,
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: HubTheme.hubSmallPadding),
                child: Text(
                  country.name ?? country.iso3code,
                  maxLines: 2,
                ),
              ),
            ),
            const Spacer(),
            if (suffix != null) suffix ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
