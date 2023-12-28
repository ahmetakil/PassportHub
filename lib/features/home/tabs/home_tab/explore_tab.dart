import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_tile.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_field.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CountrySearchBloc, CountrySearchState>(
        builder: (context, state) {
          final List<Country> allCountryList =
              context.read<CountrySearchBloc>().allCountryList;
          final List<Country> searchResults = state.getSearchResults();

          final List<Country> countryList =
              searchResults.isEmpty ? allCountryList : searchResults;

          return Column(
            children: [
              const HubPageTitle(title: "Explore"),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: HubTheme.hubMediumPadding,
                ),
                child: CountrySearchField(),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      separatorBuilder: (_, __) => Divider(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      itemCount: countryList.length,
                      itemBuilder: (context, i) {
                        final Country country = countryList[i];
                        return InkWell(
                          onTap: () {
                            context.pushNamed(
                              AppRouter.countryDetails,
                              pathParameters: {
                                "iso": country.iso3code,
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: HubTheme.hubSmallPadding,
                            ),
                            child: HubCountryTile(
                              country: country,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
