import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/ui/widgets/hub_text_field.dart';
import 'package:passport_hub/features/home/bloc/country_search_bloc.dart';

class CountrySearchField extends StatefulWidget {
  const CountrySearchField({super.key});

  @override
  State<CountrySearchField> createState() => _CountrySearchFieldState();
}

class _CountrySearchFieldState extends State<CountrySearchField> {
  final TextEditingController _countryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return HubTextField(
      keyboardType: TextInputType.text,
      debounce: true,
      onChanged: (String value) {
        if (value.length < 2) {
          return;
        }

        context.read<CountrySearchBloc>().add(
              CountrySearchEvent(
                searchQuery: value,
              ),
            );
      },
      controller: _countryNameController,
    );
  }
}
