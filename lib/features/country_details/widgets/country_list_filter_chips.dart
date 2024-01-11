import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

enum CountryListFilterChipOptions {
  all,
  visaFree,
  visaOnArrival,
  eVisa,
  visaRequired,
}

extension on CountryListFilterChipOptions {
  String get label {
    switch (this) {
      case CountryListFilterChipOptions.all:
        return "All";
      case CountryListFilterChipOptions.visaFree:
        return "Visa Free";
      case CountryListFilterChipOptions.visaOnArrival:
        return "Visa on Arrival";
      case CountryListFilterChipOptions.eVisa:
        return "eVisa";
      case CountryListFilterChipOptions.visaRequired:
        return "Visa Required";
    }
  }
}

class CountryListFilterChips extends StatelessWidget {
  final List<Country> targetCountryList;
  final bool isSearchScreen;

  const CountryListFilterChips({
    super.key,
    required this.targetCountryList,
    required this.isSearchScreen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountrySearchBloc, CountrySearchState>(
      builder: (context, state) {
        final selectedOption = state.selectedFilterOption;

        return SizedBox(
          height: 30,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final option = CountryListFilterChipOptions.values[i];

              return _CountryListFilterChip(
                option: option,
                isSelected: selectedOption == option,
                targetCountryList: targetCountryList,
                isSearchScreen: isSearchScreen,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              width: HubTheme.hubSmallPadding,
            ),
            itemCount: CountryListFilterChipOptions.values.length,
          ),
        );
      },
    );
  }
}

class _CountryListFilterChip extends StatelessWidget {
  final List<Country> targetCountryList;
  final CountryListFilterChipOptions option;
  final bool isSelected;
  final bool isSearchScreen;

  const _CountryListFilterChip({
    required this.option,
    required this.targetCountryList,
    required this.isSearchScreen,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        HubTheme.hubBorderRadius,
      ),
      onTap: () {
        context.read<CountrySearchBloc>().add(
              SelectListFilterEvent(
                option: option,
                targetCountryList: targetCountryList,
                searchAfterFiltering: isSearchScreen,
              ),
            );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: HubTheme.hubSmallPadding,
          vertical: HubTheme.hubTinyPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            HubTheme.hubBorderRadius,
          ),
          color: isSelected
              ? HubTheme.blueLight
              : HubTheme.blueLight.withOpacity(0.25),
        ),
        child: Text(
          option.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    isSelected ? Colors.white : HubTheme.black.withOpacity(0.4),
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
