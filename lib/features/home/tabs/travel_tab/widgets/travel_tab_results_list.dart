import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_icon.dart';
import 'package:passport_hub/features/country_details/widgets/country_list_filter_chips.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_tab_list_result_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TravelTabResultsListView extends StatefulWidget {
  final VisaMatrix visaMatrix;
  final List<Country> selectedCountryList;

  const TravelTabResultsListView({
    super.key,
    required this.visaMatrix,
    required this.selectedCountryList,
  });

  @override
  State<TravelTabResultsListView> createState() =>
      _TravelTabResultsListViewState();
}

class _TravelTabResultsListViewState extends State<TravelTabResultsListView> {
  List<Country> get countryList => widget.visaMatrix.countryList;

  late Map<Country, VisaRequirementType> countryToRequirementsMap;

  @override
  void initState() {
    countryToRequirementsMap =
        widget.visaMatrix.generateRequirementMapForCountryGroups(
      countryList: widget.selectedCountryList,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedCountryList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(HubTheme.hubMediumPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HubImage(
                  image: HubImages.cartoonAirplane,
                  fit: BoxFit.cover,
                  width: 300,
                ),
                Text(
                  "Ready to explore? ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: HubTheme.hubSmallPadding),
                  child: Text(
                    "Select countries to discover where you can travel without a visa.\n Let's start your adventure!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        : CustomScrollView(
            slivers: [
              SliverPinnedHeader(
                child: Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: HubTheme.hubMediumPadding,
                          right: HubTheme.hubMediumPadding,
                          bottom: HubTheme.hubSmallPadding,
                        ),
                        child: CountryListFilterChips(
                          targetCountryList: widget.selectedCountryList,
                          isSearchScreen: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<CountrySearchBloc, CountrySearchState>(
                builder: (context, state) {
                  final List<Country> results = state.getResultsOrEmpty() ?? [];

                  final List<Country> countryListResults =
                      results.isEmpty ? countryList : results;

                  return SliverList.separated(
                    separatorBuilder: (_, __) => Divider(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    itemCount: countryListResults.length,
                    itemBuilder: (context, i) {
                      final Country country = countryListResults[i];
                      return TravelTabListResultTile(
                        country: country,
                        visaRequirementType:
                            countryToRequirementsMap[country] ??
                                VisaRequirementType.none,
                      );
                    },
                  );
                },
              ),
            ],
          );
  }
}
