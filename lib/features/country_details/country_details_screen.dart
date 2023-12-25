import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';
import 'package:passport_hub/common/ui/widgets/hub_loading.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/hub_world_map.dart';

class CountryDetails extends StatelessWidget {
  final String isoCode;

  const CountryDetails({
    super.key,
    required this.isoCode,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocConsumer<VisaBloc, VisaState>(
        listener: (context, state) {
          if (state.visaMatrix == null) {
            context.read<VisaBloc>().add(
                  const FetchMatrixEvent(),
                );
          }
        },
        builder: (context, state) {
          final VisaMatrix? matrix = state.visaMatrix;
          final Country? country = matrix?.getCountryByIso(isoCode);

          if (matrix == null || country == null) {
            return const HubLoading();
          }

          return HubScaffold(
            appBar: AppBar(
              title: Text("${country.name}"),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    HubCountryFlag(
                      country: country,
                      size: 40,
                    ),
                    Text("${country.name}"),
                  ],
                ),
                Row(
                  children: [
                    Text("${country.region}"),
                  ],
                ),
                HubWorldMap.destinationMap(
                  visaMatrix: matrix,
                  selectedCountry: country,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
