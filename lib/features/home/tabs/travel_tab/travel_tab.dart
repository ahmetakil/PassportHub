import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';
import 'package:passport_hub/common/ui/widgets/hub_text_field.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/hub_world_map.dart';

class TravelTab extends StatelessWidget {
  const TravelTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<VisaBloc, VisaState>(
        builder: (context, state) {
          final VisaMatrix? visaMatrix = state.visaMatrix;

          if (visaMatrix != null) {
            return Column(
              children: [
                const HubPageTitle(title: "Travel"),
                Hero(
                  tag: "travel_search_field",
                  child: Material(
                    color: Colors.transparent,
                    child: HubTextField(
                      enabled: false,
                      onTap: () {
                        context.pushNamed(AppRouter.search);
                      },
                    ),
                  ),
                ),
                HubWorldMap.combinedMap(
                  visaMatrix: visaMatrix,
                  selectedCountryList: const [],
                ),
              ],
            );
          }

          return const Center(
            child: Text(
              "Could not fetch data, \n Please try again later!",
            ),
          );
        },
      ),
    );
  }
}
