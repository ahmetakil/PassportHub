import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';

class HubWorldMap extends StatefulWidget {
  final VisaMatrix visaMatrix;
  final Map<String, Color> mapColors;

  const HubWorldMap({
    super.key,
    required this.visaMatrix,
    required this.mapColors,
  });

  HubWorldMap.destinationMap({
    super.key,
    required this.visaMatrix,
    required Country selectedCountry,
  }) : mapColors = visaMatrix.generateColorMapForCountryRequirements(
          targetCountry: selectedCountry,
        );

  HubWorldMap.combinedMap({
    super.key,
    required this.visaMatrix,
    required List<Country> selectedCountryList,
  }) : mapColors = visaMatrix.generateColorMapForCountryGroups(
          countryList: selectedCountryList,
        );

  @override
  State<HubWorldMap> createState() => _HubWorldMapState();
}

class _HubWorldMapState extends State<HubWorldMap>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;

  double minScale = 0.1;
  double maxScale = 4;

  final initialZoomFactor = 0.5;
  final xTranslate = 200.0;
  final yTranslate = 0.0;

  @override
  void initState() {
    super.initState();

    _transformationController = TransformationController();

    _transformationController.value.setEntry(0, 0, initialZoomFactor);
    _transformationController.value.setEntry(1, 1, initialZoomFactor);
    _transformationController.value.setEntry(2, 2, initialZoomFactor);
    _transformationController.value.setEntry(0, 3, -xTranslate);
    _transformationController.value.setEntry(1, 3, -yTranslate);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          constrained: false,
          transformationController: _transformationController,
          maxScale: maxScale,
          minScale: minScale,
          child: SizedBox(
            child: SimpleMap(
              countryBorder: CountryBorder(
                color: Colors.black.withOpacity(0.5),
                width: 1.0,
              ),
              fit: BoxFit.fitHeight,
              instructions: SMapWorld.instructions,
              defaultColor: Colors.grey,
              colors: widget.mapColors,
              callback: (id, name, tapdetails) {
              },
            ),
          ),
        ),
      ),
    );
  }
}
