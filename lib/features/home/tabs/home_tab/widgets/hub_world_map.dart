import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';

class HubWorldMap extends StatelessWidget {
  final VisaMatrix visaMatrix;

  const HubWorldMap({
    super.key,
    required this.visaMatrix,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> y = visaMatrix.countryList
        .map((e) => e.iso2code)
        .whereType<String>()
        .toList();
    final Map<String, Color> x = Map<String, Color>.fromIterable(
      y,
      value: (country) => Colors.green,
    );
    return InteractiveViewer(
      maxScale: 75,
      child: SimpleMap(
        instructions: SMapWorld.instructions,
        defaultColor: Colors.grey,
        colors: x,
        callback: (id, name, tapdetails) {},
      ),
    );
  }
}
