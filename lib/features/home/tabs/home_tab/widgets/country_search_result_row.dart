import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_tile.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';

class CountrySearchResultTile extends StatelessWidget {
  final Country country;
  final bool isSelected;
  final bool isCompare;

  const CountrySearchResultTile({
    super.key,
    required this.country,
    required this.isCompare,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isCompare) {
          context.read<CompareBloc>().add(
                SelectCountryForCompareEvent(country: country),
              );
          return;
        }

        context.read<CountrySearchBloc>().add(
              SelectCountryEvent(country: country),
            );
      },
      child: HubCountryTile(
        country: country,
        suffix: Opacity(
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
      ),
    );
  }
}
