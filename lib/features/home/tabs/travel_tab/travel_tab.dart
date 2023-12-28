import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_fake_text_field.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/hub_world_map.dart';
import 'package:passport_hub/common/ui/widgets/hub_segmented_control.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_search_result_list_view.dart';

class TravelTab extends StatefulWidget {
  const TravelTab({super.key});

  @override
  State<TravelTab> createState() => _TravelTabState();
}

class _TravelTabState extends State<TravelTab> {
  bool showMap = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<VisaBloc, VisaState>(
        builder: (context, state) {
          final VisaMatrix? visaMatrix = state.visaMatrix;

          return BlocBuilder<CountrySearchBloc, CountrySearchState>(
            builder: (context, state) {
              final List<Country> selectedCountryList =
                  state.getSelectedCountryList();
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const HubPageTitle(title: "Travel"),
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
                    child: Hero(
                      tag: "travel_search_field",
                      child: Material(
                        color: Colors.transparent,
                        child: HubFakeTextField(
                          showEmpty: selectedCountryList.isEmpty,
                          child: TravelSearchResultListView(
                            countryList: selectedCountryList,
                          ),
                          onTap: () {
                            context.pushNamed(AppRouter.search);
                          },
                        ),
                      ),
                    ),
                  ),
                  if (visaMatrix != null)
                    HubWorldMap.combinedMap(
                      visaMatrix: visaMatrix,
                      selectedCountryList: selectedCountryList,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
