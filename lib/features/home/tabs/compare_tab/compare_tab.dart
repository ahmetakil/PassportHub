import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_error_screen.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_fake_text_field.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/widgets/travel_search_result_list_view.dart';

class CompareTab extends StatelessWidget {
  const CompareTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisaBloc, VisaState>(
      builder: (context, state) {
        final VisaMatrix? visaMatrix = state.visaMatrix;

        if (visaMatrix == null) {
          return const HubErrorScreen();
        }

        return SafeArea(
          child: BlocBuilder<CompareBloc, CompareState>(
            builder: (context, state) {
              final List<Country> selectedCountryList =
                  state.getSelectedCompareList();

              return Column(
                children: [
                  const HubPageTitle(title: "Compare"),
                  Padding(
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
