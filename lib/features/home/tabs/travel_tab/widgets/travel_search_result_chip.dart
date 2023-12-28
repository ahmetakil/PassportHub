import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';

class TravelSearchResultChip extends StatelessWidget {
  final Country country;

  const TravelSearchResultChip({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HubCountryFlag(
          country: country,
          size: 20,
        ),
        Text("${country.iso3code}"),
        IconButton(
          onPressed: () {
            context.read<CountrySearchBloc>().add(
                  SelectCountryEvent(
                    country: country,
                  ),
                );
          },
          icon: Icon(
            Icons.clear,
            size: 12,
          ),
        ),
      ],
    );
  }
}
