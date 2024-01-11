import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';

class TravelSearchResultChip extends StatelessWidget {
  final Country country;

  const TravelSearchResultChip({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CountrySearchBloc>().add(
              SelectCountryEvent(
                country: country,
              ),
            );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
          color: HubTheme.onPrimary.withOpacity(0.4),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: HubCountryFlag(
                country: country,
                width: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                country.iso3code,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Icon(
              Icons.clear,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
