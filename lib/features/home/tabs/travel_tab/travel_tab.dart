import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_text_field.dart';
import 'package:passport_hub/features/home/bloc/country_search_bloc.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_field.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/country_search_results.dart';
import 'package:passport_hub/features/home/tabs/home_tab/widgets/hub_world_map.dart';

class TravelTab extends StatelessWidget {
  const TravelTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisaBloc, VisaState>(
      builder: (context, state) {
        final VisaMatrix? visaMatrix = state.visaMatrix;

        if (visaMatrix != null) {
          return Column(
            children: [
              Text("Travel"),
              HubTextField(),
              //HubWorldMap.combined(visaMatrix: visaMatrix, mapColors: mapColors)
            ],
          );
        }

        return const Center(
          child: Text(
            "Could not fetch data, \n Please try again later!",
          ),
        );
      },
    );
  }
}
