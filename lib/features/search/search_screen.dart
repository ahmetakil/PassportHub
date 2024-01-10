import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_back_icon.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_field.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_results.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisaBloc, VisaState>(
      builder: (context, state) {
        return HubScaffold(
          body: const SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: HubTheme.hubMediumPadding,
                  ),
                  child: Row(
                    children: [
                      HubBackIcon(),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: CountrySearchField(
                            autofocus: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(
                          top: HubTheme.hubMediumPadding,
                        ),
                        sliver: CountrySearchResults(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton:
              BlocBuilder<CountrySearchBloc, CountrySearchState>(
            builder: (context, state) {
              final bool hideFab = state.getSelectedCountryList().isEmpty;
              return hideFab
                  ? const SizedBox.shrink()
                  : FloatingActionButton(
                      child: Icon(
                        Icons.check,
                        color: HubTheme.black,
                      ),
                      backgroundColor: HubTheme.onPrimary.withOpacity(0.5),
                      onPressed: () => context.pop(),
                    );
            },
          ),
        );
      },
    );
  }
}
