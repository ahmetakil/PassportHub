import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';

class HubCountryFlag extends StatelessWidget {
  final Country country;
  final double size;

  const HubCountryFlag({
    required this.country,
    this.size = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCountryCode(
      country.iso2code ?? "",
      width: size,
      height: size,
    );
  }
}
