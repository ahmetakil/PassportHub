import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';

class HubWorldMap extends StatelessWidget {
  final VisaMatrix visaMatrix;
  final Country selectedCountry;

  const HubWorldMap({
    super.key,
    required this.visaMatrix,
    required this.selectedCountry,
  });

  @override
  Widget build(BuildContext context) {
    final List<Country> visaFreeCountries =
        visaMatrix.getCountriesByRequirement(
      targetCountry: selectedCountry,
      requirementType: VisaRequirementType.visaFree,
    );

    final List<String> y = visaFreeCountries
        .map(
          (Country e) => e.iso2code?.toLowerCase(),
        )
        .whereType<String>()
        .toList();
    final Map<String, Color> x = Map<String, Color>.fromIterable(
      y,
      value: (country) => Colors.green,
    );
    return InteractiveViewer(
      maxScale: 5,
      scaleFactor: 1.0,
      child: SimpleMap(
        instructions: SMapWorld.instructions,
        defaultColor: Colors.grey,
        colors: x,
        callback: (id, name, tapdetails) {},
      ),
    );
  }
}
