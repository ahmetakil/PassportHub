import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/features/home/bloc/country_search_bloc.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_result_chip.dart';

class CountrySearchResults extends StatelessWidget {
  const CountrySearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: HubTheme.hubSmallPadding),
      sliver: BlocBuilder<CountrySearchBloc, CountrySearchState>(
        builder: (context, state) {
          return switch (state) {
            CountrySearchInitialState() => const SliverToBoxAdapter(
                child: SizedBox.shrink(),
              ),
            CountrySearchResultsState(:final List<Country> results) =>
              SliverList.separated(
                separatorBuilder: (_, __) => Divider(
                  color: Colors.grey.withOpacity(0.2),
                ),
                itemCount: results.length,
                itemBuilder: (context, i) => CountrySearchResultRow(
                  country: results[i],
                ),
              ),
          };
        },
      ),
    );
  }
}
