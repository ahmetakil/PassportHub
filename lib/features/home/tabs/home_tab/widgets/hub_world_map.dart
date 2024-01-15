import 'package:another_flushbar/flushbar.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

class HubWorldMap extends StatefulWidget {
  final VisaMatrix visaMatrix;
  final Map<String, Color> mapColors;
  final List<Country> selectedCountryList;

  HubWorldMap({
    super.key,
    required this.visaMatrix,
    required this.selectedCountryList,
  }) : mapColors = visaMatrix.generateColorMapForCountryGroups(
          countryList: selectedCountryList,
        );

  @override
  State<HubWorldMap> createState() => _HubWorldMapState();
}

class _HubWorldMapState extends State<HubWorldMap>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;

  late Map<String, Color> mapColors;

  double minScale = 0.1;
  double maxScale = 4;

  final initialZoomFactor = 0.8;
  final xTranslate = 800.0;
  final yTranslate = 0.0;

  @override
  void didUpdateWidget(covariant HubWorldMap oldWidget) {
    mapColors = widget.mapColors;

    updateMapColorsForSelectedCountryList(widget.selectedCountryList);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    updateMapColorsForSelectedCountryList(widget.selectedCountryList);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    mapColors = widget.mapColors;

    super.initState();

    _transformationController = TransformationController();
    _transformationController.value.setEntry(0, 0, initialZoomFactor);
    _transformationController.value.setEntry(1, 1, initialZoomFactor);
    _transformationController.value.setEntry(2, 2, initialZoomFactor);
    _transformationController.value.setEntry(0, 3, -xTranslate);
    _transformationController.value.setEntry(1, 3, -yTranslate);
  }

  void updateMapColorsForSelectedCountryList(
    List<Country> selectedCountryList,
  ) {
    for (final Country country in selectedCountryList) {
      final String? iso2 = country.iso2code;

      if (iso2 == null) {
        continue;
      }

      mapColors[iso2.toLowerCase()] = VisaRequirementTypeExtension.self;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: InteractiveViewer(
        constrained: false,
        transformationController: _transformationController,
        maxScale: maxScale,
        minScale: minScale,
        child: Stack(
          children: [
            SimpleMap(
              countryBorder: CountryBorder(
                color: Colors.black.withOpacity(0.5),
                width: 1.0,
              ),
              fit: BoxFit.fitHeight,
              instructions: SMapWorld.instructions,
              defaultColor: widget.selectedCountryList.isEmpty
                  ? HubTheme.primary
                  : Colors.grey,
              colors: mapColors,
              callback: (id, String name, TapUpDetails tapDetails) {
                final Country? tappedCountry =
                    widget.visaMatrix.getCountryByIso2(id.toUpperCase());

                if (tappedCountry == null) {
                  return;
                }

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        HubTheme.hubBorderRadius * 2,
                      ),
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "${tappedCountry.name}",
                            maxLines: 2,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              AppRouter.countryDetails,
                              pathParameters: {
                                "iso": tappedCountry.iso3code,
                              },
                            );
                          },
                          child: Text(
                            "Details",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: HubTheme.yellow,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
