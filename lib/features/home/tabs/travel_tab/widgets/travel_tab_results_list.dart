import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_tab_list_result_tile.dart';

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
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(
            top: HubTheme.hubMediumPadding,
          ),
          sliver: SliverList.separated(
            separatorBuilder: (_, __) => Divider(
              color: Colors.grey.withOpacity(0.2),
            ),
            itemCount: countryList.length,
            itemBuilder: (context, i) {
              final Country country = countryList[i];
              return TravelTabListResultTile(
                country: country,
                visaRequirementType: countryToRequirementsMap[country] ??
                    VisaRequirementType.none,
              );
            },
          ),
        ),
      ],
    );
  }
}
