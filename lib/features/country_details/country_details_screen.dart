import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/widgets/hub_loading.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';

class CountryDetails extends StatelessWidget {
  final String isoCode;

  const CountryDetails({
    super.key,
    required this.isoCode,
  });

  @override
  Widget build(BuildContext context) {
    return HubScaffold(
      body: BlocConsumer<VisaBloc, VisaState>(
        listener: (context, state) {
          if (state.visaMatrix == null) {
            context.read<VisaBloc>().add(
                  const FetchMatrixEvent(),
                );
          }
        },
        builder: (context, state) {
          final Country? country = state.visaMatrix?.getCountryByIso(isoCode);

          if (country == null) {
            return const HubLoading();
          }

          return Column(
            children: [
              Text("${country.name}"),
              Text("${country.region}"),
            ],
          );
        },
      ),
    );
  }
}
