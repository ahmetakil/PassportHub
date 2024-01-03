import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';

const _flagAspectRatio = 16 / 10;

class HubCountryFlag extends StatelessWidget {
  final Country country;
  final double width;
  final double aspectRatio;
  final double? height;
  final BoxFit? fit;

  const HubCountryFlag({
    required this.country,
    this.width = 32,
    this.aspectRatio = _flagAspectRatio,
    this.height,
    this.fit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCountryCode(
      country.iso2code ?? "",
      width: width,
      height: height ?? width / aspectRatio,
      borderRadius: 4.0,
      boxFit: fit ?? BoxFit.contain,
    );
  }
}
