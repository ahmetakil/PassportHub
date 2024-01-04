import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_tile.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_field.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CountryDetailsCountryList extends StatelessWidget {
  final List<Country> countryList;

  const CountryDetailsCountryList({super.key, required this.countryList});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountrySearchBloc>(
      create: (_) => CountrySearchBloc()
        ..add(
          SetCountryList(allCountryList: countryList),
        ),
      child: SliverPadding(
        padding: const EdgeInsets.only(top: HubTheme.hubMediumPadding),
        sliver: MultiSliver(
          children: [
            const SliverPinnedHeader(
              child: Material(
                child: CountrySearchField(
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            BlocBuilder<CountrySearchBloc, CountrySearchState>(
              builder: (context, state) {
                final searchResults = state.getSearchResults();

                final List<Country> countryListResults =
                    searchResults.isEmpty ? countryList : searchResults;

                return SliverPadding(
                  padding:
                      const EdgeInsets.only(top: HubTheme.hubMediumPadding),
                  sliver: SliverList.separated(
                    separatorBuilder: (_, __) => Divider(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    itemCount: countryListResults.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {},
                        child: HubCountryTile(
                          country: countryListResults[i],
                          padding: const EdgeInsets.symmetric(
                            vertical: HubTheme.hubSmallPadding,
                          ),
                          suffix: const Text(""),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
