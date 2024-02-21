import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_divider.dart';
import 'package:passport_hub/common/ui/widgets/hub_icon.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/widgets/compare_content/compare_content_header.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/widgets/compare_content/compare_content_section_title.dart';

class CompareContent extends StatelessWidget {
  const CompareContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisaBloc, VisaState>(
      builder: (context, visaState) {
        final visaMatrix = visaState.visaMatrix;

        if (visaMatrix == null) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<CompareBloc, CompareState>(
          builder: (context, state) {
            final List<Country> countryList = state.selectedCountryList;

            if (countryList.length < 2) {
              return const SizedBox.shrink();
            }

            final Country left = countryList[0];
            final Country right = countryList[1];

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: HubTheme.hubMediumPadding,
              ),
              child: Column(
                children: [
                  CompareContentHeader(
                    right: right,
                    left: left,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: HubTheme.hubSmallPadding,
                    ),
                    child: HubDivider(),
                  ),
                  CompareContentSectionTitle(
                    right: right,
                    left: left,
                    title: "Passport Ranking",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: HubTheme.hubMediumPadding,
                    ),
                    child: Row(
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
                          "${visaMatrix.getPassportRanking(left)}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        Text(
                          "${visaMatrix.getPassportRanking(right)}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: HubTheme.hubSmallPadding,
                          ),
                          child: HubIcon(
                            HubIcons.medal,
                            height: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
