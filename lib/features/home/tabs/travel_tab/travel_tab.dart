import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_error_screen.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_fake_text_field.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/common/ui/widgets/hub_segmented_control.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/hub_world_map.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_search_result_list_view.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_tab_info_sheet.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_tab_results_list.dart';

class TravelTab extends StatefulWidget {
  const TravelTab({
    super.key,
  });

  @override
  State<TravelTab> createState() => _TravelTabState();
}

class _TravelTabState extends State<TravelTab> {
  bool showMap = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisaBloc, VisaState>(
      builder: (context, state) {
        final VisaMatrix? visaMatrix = state.visaMatrix;

        if (visaMatrix == null) {
          return const HubErrorScreen();
        }

        return SafeArea(
          child: BlocBuilder<CountrySearchBloc, CountrySearchState>(
            builder: (context, state) {
              final List<Country> selectedCountryList =
                  state.getSelectedCountryList();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showMaterialModalBottomSheet(
                            useRootNavigator: true,
                            context: context,
                            builder: (_) => const FractionallySizedBox(
                              heightFactor: 0.7,
                              child: TravelTabInfoSheet(),
                            ),
                          );
                        },
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            HubPageTitle(title: "Travel"),
                            Padding(
                              padding: EdgeInsets.only(
                                left: HubTheme.hubSmallPadding,
                              ),
                              child: Icon(Icons.info_outline),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: HubTheme.hubMediumPadding,
                        ),
                        child: HubSegmentedControl(
                          groupValue: showMap ? "Map" : "List",
                          options: const ["Map", "List"],
                          onValueChanged: (String? val) {
                            if (val == "List") {
                              showMap = false;
                            } else {
                              showMap = true;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: HubTheme.hubMediumPadding,
                    ),
                    child: HubFakeTextField(
                      showEmpty: selectedCountryList.isEmpty,
                      child: TravelSearchResultListView(
                        countryList: selectedCountryList,
                        isCompareScreen: false,
                      ),
                      onTap: () {
                        context.pushNamed(AppRouter.search);
                      },
                    ),
                  ),
                  Expanded(
                    child: showMap
                        ? HubWorldMap(
                            visaMatrix: visaMatrix,
                            selectedCountryList: selectedCountryList,
                          )
                        : TravelTabResultsListView(
                            visaMatrix: visaMatrix,
                            selectedCountryList: selectedCountryList,
                          ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
