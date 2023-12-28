import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';

const _flagAspectRatio = 16 / 10;

class HubCountryFlag extends StatelessWidget {
  final Country country;
  final double size;
  final double aspectRatio;

  const HubCountryFlag({
    required this.country,
    this.size = 32,
    this.aspectRatio = _flagAspectRatio,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCountryCode(
      country.iso2code ?? "",
      width: size,
      height: size / aspectRatio,
      borderRadius: 4.0,
    );
  }
}
