import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_tile.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_field.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CountryDetailsCountryList extends StatefulWidget {
  final VisaMatrix matrix;
  final Country targetCountry;

  const CountryDetailsCountryList({
    super.key,
    required this.matrix,
    required this.targetCountry,
  });

  @override
  State<CountryDetailsCountryList> createState() =>
      _CountryDetailsCountryListState();
}

class _CountryDetailsCountryListState extends State<CountryDetailsCountryList> {
  late List<Country> countryList;
  late Map<VisaRequirementType, List<Country>> requirementTypesMap;

  @override
  void initState() {
    requirementTypesMap = widget.matrix.getCountriesGroupedByRequirement(
      targetCountry: widget.targetCountry,
    );

    countryList = requirementTypesMap.values
        .expand(
          (List<Country> element) => element,
        )
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountrySearchBloc>(
      create: (_) => CountrySearchBloc()
        ..add(
          SetCountryList(
            allCountryList: countryList,
          ),
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
                      final Country country = countryListResults[i];
                      final VisaInformation? visaInformation = widget.matrix
                          .getVisaInformation(
                              from: widget.targetCountry, to: country);

                      return InkWell(
                        onTap: () {},
                        child: HubCountryTile(
                          country: country,
                          padding: const EdgeInsets.symmetric(
                            vertical: HubTheme.hubSmallPadding,
                          ),
                          suffix: Text(
                            "${visaInformation?.requirement.type.label}",
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
