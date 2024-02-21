import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_error_screen.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_back_icon.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/widgets/compare_search_field.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/widgets/compare_search_results.dart';

class CompareSearchScreen extends StatefulWidget {
  const CompareSearchScreen({super.key});

  @override
  State<CompareSearchScreen> createState() => _CompareSearchScreenState();
}

class _CompareSearchScreenState extends State<CompareSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisaBloc, VisaState>(
      builder: (context, state) {
        final VisaMatrix? visaMatrix = state.visaMatrix;

        if (visaMatrix == null) {
          return const HubErrorScreen();
        }

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
                          child: CompareSearchField(
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
                        sliver: CompareSearchResults(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: BlocBuilder<CompareBloc, CompareState>(
            builder: (context, state) {
              return const SizedBox.shrink();
              /*  final bool hideFab = state.getSelectedCountryList().isEmpty;
              return hideFab
                  ? const SizedBox.shrink()
                  : FloatingActionButton(
                      backgroundColor: HubTheme.onPrimary.withOpacity(0.5),
                      onPressed: () => context.pop(),
                      child: const Icon(
                        Icons.check,
                        color: HubTheme.black,
                      ),
                    );*/
            },
          ),
        );
      },
    );
  }
}
