import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_fake_text_field.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_search_result_list_view.dart';

class CompareSearchHeader extends StatelessWidget {
  final List<Country> selectedCountryList;

  const CompareSearchHeader({super.key, required this.selectedCountryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: HubTheme.hubMediumPadding,
      ),
      child: HubFakeTextField(
        showEmpty: selectedCountryList.isEmpty,
        emptyLabel: "Search Country",
        child: TravelSearchResultListView(
          countryList: selectedCountryList,
          isCompareScreen: true,
        ),
        onTap: () {
          context.pushNamed(
            AppRouter.compareSearch,
          );
        },
      ),
    );
  }
}
