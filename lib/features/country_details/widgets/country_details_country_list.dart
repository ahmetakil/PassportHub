import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_tile.dart';

class CountryDetailsCountryList extends StatelessWidget {
  final List<Country> countryList;

  const CountryDetailsCountryList({super.key, required this.countryList});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: HubTheme.hubMediumPadding),
      sliver: SliverList.separated(
        separatorBuilder: (_, __) => Divider(
          color: Colors.grey.withOpacity(0.2),
        ),
        itemCount: countryList.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {},
            child: HubCountryTile(
              country: countryList[i],
              padding: const EdgeInsets.symmetric(
                vertical: HubTheme.hubSmallPadding,
              ),
              suffix: Text(""),
            ),
          );
        },
      ),
    );
  }
}
