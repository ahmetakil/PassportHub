import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/ui/widgets/hub_text_field.dart';

class CountrySearchField extends StatefulWidget {
  final bool autofocus;

  const CountrySearchField({
    super.key,
    this.autofocus = false,
  });

  @override
  State<CountrySearchField> createState() => _CountrySearchFieldState();
}

class _CountrySearchFieldState extends State<CountrySearchField> {
  final TextEditingController _countryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return HubTextField(
      autofocus: widget.autofocus,
      keyboardType: TextInputType.text,
      debounce: true,
      onChanged: (String value) {
        if (value.length < 2) {
          return;
        }

        context.read<CountrySearchBloc>().add(
              CountrySearchQueryEvent(
                searchQuery: value,
              ),
            );
      },
      controller: _countryNameController,
    );
  }
}
