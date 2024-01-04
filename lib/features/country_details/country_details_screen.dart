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
import 'package:passport_hub/features/country_details/widgets/country_details_action_buttons.dart';
import 'package:passport_hub/features/country_details/widgets/country_details_country_list.dart';

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
            return HubScaffold(
              appBar: AppBar(
                leading: const HubBackIcon(),
              ),
              body: const Center(
                child: HubLoading(),
              ),
            );
          }

          return HubScaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: HubTheme.hubMediumPadding,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const HubBackIcon(),
                              Flexible(
                                child: HubPageTitle(
                                  title: country.name ?? "",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HubPassportImage(
                                country: country,
                              ),
                              HubCountryFlag(
                                country: country,
                                width: 140,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: HubTheme.hubMediumPadding,
                            ),
                            child: HubDivider(),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Passport Ranking",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: HubTheme.hubTinyPadding,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            right: HubTheme.hubSmallPadding,
                                          ),
                                          child: HubIcon(
                                            HubIcons.medal,
                                            height: 18,
                                          ),
                                        ),
                                        Text(
                                          "103",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 42,
                                  child: VerticalDivider(
                                    width: 1,
                                    thickness: 1,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Visa Free Access",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color:
                                              HubTheme.black.withOpacity(0.6),
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: HubTheme.hubTinyPadding,
                                    ),
                                    child: Text(
                                      "26 Countries",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const CountryDetailsActionButtons(),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: HubTheme.hubMediumPadding,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Visa Requirements by\nCountry",
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CountryDetailsCountryList(
                      matrix: matrix,
                      targetCountry: country,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
