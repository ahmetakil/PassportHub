import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
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
    return GestureDetector(
      onTap: () {
        context.read<CountrySearchBloc>().add(
              SelectCountryEvent(country: country),
            );
      },
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
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: HubTheme.hubSmallPadding),
                  child: Text(
                    country.name ?? country.iso3code,
                    maxLines: 2,
                  ),
                ),
              ),
              const Spacer(),
              Opacity(
                opacity: isSelected ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: HubTheme.hubSmallPadding,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
