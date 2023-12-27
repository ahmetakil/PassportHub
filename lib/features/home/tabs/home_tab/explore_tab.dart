import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_field.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_results.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<VisaBloc, VisaState>(
        builder: (context, state) {
          return const Column(
            children: [
              HubPageTitle(title: "Explore"),
              CountrySearchField(),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(top: HubTheme.hubMediumPadding),
                      sliver: CountrySearchResults(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
