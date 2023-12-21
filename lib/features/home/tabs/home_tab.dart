import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/widgets/country_data_table.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: CountryDataTable(),
        ),
      ],
    );
  }
}
