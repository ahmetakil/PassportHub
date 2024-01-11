import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_tile.dart';
import 'package:passport_hub/features/country_details/widgets/country_list_filter_chips.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_field.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CountryDetailsCountryList extends StatelessWidget {
  final VisaMatrix matrix;
  final Country targetCountry;

  const CountryDetailsCountryList({
    super.key,
    required this.matrix,
    required this.targetCountry,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountrySearchBloc>(
      create: (_) => CountrySearchBloc()
        ..add(
          SetCountryList(
            matrix: matrix,
          ),
        ),
      child: SliverPadding(
        padding: const EdgeInsets.only(top: HubTheme.hubMediumPadding),
        sliver: MultiSliver(
          children: [
            SliverPinnedHeader(
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: HubTheme.hubMediumPadding,
                      ),
                      child: CountryListFilterChips(
                        targetCountryList: [
                          targetCountry,
                        ],
                        isSearchScreen: true,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(bottom: HubTheme.hubSmallPadding),
                      child: CountrySearchField(
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<CountrySearchBloc, CountrySearchState>(
              builder: (context, state) {
                final List<Country> countryListResults =
                    state.getResultsOrEmpty() ?? matrix.countryList;

                countryListResults.removeWhere(
                  (element) => element.iso3code == targetCountry.iso3code,
                );

                return SliverPadding(
                  padding:
                      const EdgeInsets.only(top: HubTheme.hubMediumPadding),
                  sliver: SliverList.separated(
                    separatorBuilder: (_, __) => Divider(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    itemCount: countryListResults.length,
                    itemBuilder: (context, i) {
                      final Country country = countryListResults[i];
                      final VisaInformation? visaInformation =
                          matrix.getVisaInformation(
                        from: targetCountry,
                        to: country,
                      );

                      return InkWell(
                        onTap: () {},
                        child: HubCountryTile(
                          country: country,
                          padding: const EdgeInsets.symmetric(
                            vertical: HubTheme.hubSmallPadding,
                          ),
                          suffix: Text(
                            "${visaInformation?.requirement.type.label}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: HubTheme.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
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
