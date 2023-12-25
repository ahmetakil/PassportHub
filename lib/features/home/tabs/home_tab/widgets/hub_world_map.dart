import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

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
    final Map<VisaRequirementType, List<Country>> visaRequirementsMap =
        visaMatrix.getCountriesGroupedByRequirement(
      targetCountry: selectedCountry,
    );

    final Map<String, Color> mapColors = {};

    for (final MapEntry<VisaRequirementType, List<Country>> entry
        in visaRequirementsMap.entries) {
      final type = entry.key;

      final List<String> countryIsoCodes = entry.value
          .map((e) => e.iso2code?.toLowerCase())
          .whereType<String>()
          .toList();

      mapColors.addAll(
        Map.fromIterable(
          countryIsoCodes,
          value: (_) => type.color,
        ),
      );
    }

    final String selfIsoCode = selectedCountry.iso2code?.toLowerCase() ?? "";

    mapColors[selfIsoCode] = VisaRequirementTypeExtension.self;

    return InteractiveViewer(
      panEnabled: true,
      maxScale: 5,
      scaleFactor: 1.0,
      child: SimpleMap(
        fit: BoxFit.fill,
        instructions: SMapWorld.instructions,
        defaultColor: Colors.grey,
        colors: mapColors,
        callback: (id, name, tapdetails) {},
      ),
    );
  }
}
