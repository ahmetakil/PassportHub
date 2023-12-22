import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: HubTheme.hubMediumPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: HubTheme.background,
          borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HubTextField(
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
              decoration: InputDecoration(
                suffix: _countryNameController.text.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                          right: HubTheme.hubMediumPadding,
                        ),
                        child: Icon(
                          Icons.clear,
                          size: 16,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      )
                    : null,
                icon: const Padding(
                  padding: EdgeInsets.only(
                    left: HubTheme.hubSmallPadding,
                  ),
                  child: Icon(Icons.search),
                ),
                hintText: "Search",
                border: InputBorder.none,
              ),
              controller: _countryNameController,
            ),
          ],
        ),
      ),
    );
  }
}
