import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';

class CountryDataTable extends StatelessWidget {
  const CountryDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisaBloc, VisaState>(
      builder: (context, state) {
        final List<Country> countryList = state.visaMatrix?.countryList ?? [];

        return ListView.builder(
          itemCount: countryList.length,
          itemBuilder: (context, i) {
            final Country country = countryList[i];

            return Row(
              children: [
                HubCountryFlag(country: country),
                Text(" ${country.iso2code}"),
                Text("- ${country.name}"),
              ],
            );
          },
        );
      },
    );
  }
}
