import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_result_row.dart';

class CompareSearchResults extends StatelessWidget {
  const CompareSearchResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: HubTheme.hubSmallPadding),
      sliver: BlocBuilder<CompareBloc, CompareState>(
        builder: (context, state) {
          return switch (state) {
            CompareInitialState() => const SliverToBoxAdapter(
                child: SizedBox.shrink(),
              ),
            CompareResultState(
              :final List<Country> results,
              :final List<Country> selectedCountryList
            ) =>
              SliverList.separated(
                separatorBuilder: (_, __) => Divider(
                  color: Colors.grey.withOpacity(0.2),
                ),
                itemCount: results.length,
                itemBuilder: (context, i) => CountrySearchResultTile(
                  country: results[i],
                  isCompare: true,
                  isSelected: selectedCountryList.contains(
                    results[i],
                  ),
                ),
              ),
          };
        },
      ),
    );
  }
}
