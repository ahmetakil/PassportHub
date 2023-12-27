import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_error_screen.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/features/home/bloc/country_search_bloc.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_field.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_results.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<VisaBloc, VisaState>(
        builder: (context, state) {
          final VisaMatrix? visaMatrix = state.visaMatrix;

          if (visaMatrix != null) {
            return BlocProvider<CountrySearchBloc>(
              create: (_) => CountrySearchBloc(
                allCountryList: visaMatrix.countryList,
              ),
              child: const Column(
                children: [
                  HubPageTitle(title: "Explore"),
                  CountrySearchField(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding:
                              EdgeInsets.only(top: HubTheme.hubMediumPadding),
                          sliver: CountrySearchResults(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const HubErrorScreen();
        },
      ),
    );
  }
}
