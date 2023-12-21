import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/features/home/bloc/country_search_bloc.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_result_chip.dart';

class CountrySearchResults extends StatelessWidget {
  const CountrySearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HubTheme.hubSmallPadding),
      child: BlocBuilder<CountrySearchBloc, CountrySearchState>(
        builder: (context, state) {
          return switch (state) {
            CountrySearchInitialState() => const SizedBox.shrink(),
            CountrySearchResultsState(:final results) => Wrap(
                runSpacing: 8.0,
                spacing: 8.0,
                children: results
                        ?.map(
                          (result) => CountrySearchResultChip(
                            country: result,
                          ),
                        )
                        .toList() ??
                    [],
              ),
          };
        },
      ),
    );
  }
}
