import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';

class CompareContent extends StatelessWidget {
  const CompareContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompareBloc, CompareState>(
      builder: (context, state) {
        final List<Country> countryList = state.selectedCountryList;

        if (countryList.length < 2) {
          return const SizedBox.shrink();
        }

        final Country left = countryList[0];
        final Country right = countryList[1];

        return Text("content");
      },
    );
  }
}
