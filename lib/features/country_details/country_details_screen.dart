import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_back_icon.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';
import 'package:passport_hub/common/ui/widgets/hub_divider.dart';
import 'package:passport_hub/common/ui/widgets/hub_icon.dart';
import 'package:passport_hub/common/ui/widgets/hub_loading.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/common/ui/widgets/hub_passport_image.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';

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
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: HubTheme.hubSmallPadding,
                    ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: HubTheme.hubMediumPadding,
                        ),
                        child: HubPassportImage(
                          country: country,
                        ),
                      ),
                      HubCountryFlag(
                        country: country,
                        width: 260,
                        height: 86,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: HubTheme.hubMediumPadding,
                      horizontal: HubTheme.hubMediumPadding,
                    ),
                    child: HubDivider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HubTheme.hubMediumPadding,
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Passport Ranking",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    right: HubTheme.hubSmallPadding,
                                  ),
                                  child: HubIcon(
                                    HubIcons.medal,
                                    height: 16,
                                  ),
                                ),
                                Text(
                                  "103",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: VerticalDivider(
                              width: 1,
                              thickness: 2,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Visa Free Access",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "26 Countries",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
