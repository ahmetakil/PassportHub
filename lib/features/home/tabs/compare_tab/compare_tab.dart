import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_error_screen.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/widgets/compare_search_header.dart';

class CompareTab extends StatelessWidget {
  const CompareTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisaBloc, VisaState>(
      builder: (context, visaState) {
        final VisaMatrix? visaMatrix = visaState.visaMatrix;

        if (visaMatrix == null) {
          return const HubErrorScreen();
        }

        return SafeArea(
          child: BlocBuilder<CompareBloc, CompareState>(
            builder: (context, state) {
              final List<Country> selectedCountryList =
                  state.selectedCountryList;

              return Column(
                children: [
                  const HubPageTitle(title: "Compare"),
                  CompareSearchHeader(
                    selectedCountryList: selectedCountryList,
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
