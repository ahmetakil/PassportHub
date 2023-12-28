import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_search_result_chip.dart';

class TravelSearchResultListView extends StatelessWidget {
  final List<Country> countryList;

  const TravelSearchResultListView({
    super.key,
    required this.countryList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, i) => TravelSearchResultChip(
          country: countryList[i],
        ),
        separatorBuilder: (_, __) => const SizedBox(
          width: HubTheme.hubSmallPadding,
        ),
        itemCount: countryList.length,
      ),
    );
  }
}
