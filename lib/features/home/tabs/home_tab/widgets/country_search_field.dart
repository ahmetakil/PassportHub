import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

class CountrySearchField extends StatefulWidget {
  const CountrySearchField({super.key});

  @override
  State<CountrySearchField> createState() => _CountrySearchFieldState();
}

class _CountrySearchFieldState extends State<CountrySearchField> {
  late TextEditingController _countryNameController;

  @override
  void initState() {
    super.initState();
    _countryNameController = TextEditingController();
  }

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
            TextField(
              decoration: const InputDecoration(
                icon: Padding(
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
