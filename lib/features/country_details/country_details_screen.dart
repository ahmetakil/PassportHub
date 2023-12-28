import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_back_icon.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';
import 'package:passport_hub/common/ui/widgets/hub_loading.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/hub_world_map.dart';

class CountryDetails extends StatelessWidget {
  final Iso3 isoCode;

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
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: HubTheme.hubLargePadding,
                      left: HubTheme.hubSmallPadding),
                  child: Row(
                    children: [
                      const HubBackIcon(),
                      Flexible(
                        child: HubPageTitle(
                          title: country.name ?? "",
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    HubCountryFlag(
                      country: country,
                      size: 210,
                      aspectRatio: 2.4,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("${country.region}"),
                  ],
                ),
                Expanded(
                  child: HubWorldMap.destinationMap(
                    visaMatrix: matrix,
                    selectedCountry: country,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
