import 'package:collection/collection.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';

typedef Iso3 = String;

class VisaMatrix {
  final Map<Country, List<VisaInformation>> matrix;

  late Map<Iso3, Country> isoToCountryMap;

  VisaMatrix({required this.matrix})
      : isoToCountryMap = {
          for (final Country c in matrix.keys.toList()) c.iso3code: c,
        };

  List<Country> get countryList => matrix.keys.toList();

  Country? getCountryByIso(String iso3) {
    return countryList.firstWhereOrNull(
      (Country country) => country.iso3code == iso3,
    );
  }

  List<VisaInformation> getDestinations({required Country target}) {
    return matrix[target] ?? [];
  }

  VisaInformation? getVisaInformation({
    required Country from,
    required Country to,
  }) {
    return matrix[from]?.firstWhereOrNull(
      (VisaInformation target) => target.destinationCountry == to,
    );
  }

  /// Keys refers to iso3 country codes.
  VisaMatrix enhanceWithCountryList(Map<String, Country> countryList) {
    final List<MapEntry<Country, List<VisaInformation>>> entries =
        matrix.entries.toList();

    final List<MapEntry<Country, List<VisaInformation>>> newEntries = [];

    for (final MapEntry<Country, List<VisaInformation>> entry in entries) {
      late Country newCountry;
      final Country currentCountry = entry.key;

      if (countryList.containsKey(currentCountry.iso3code)) {
        newCountry = countryList[currentCountry.iso3code] ?? currentCountry;
      } else {
        newCountry = currentCountry;
      }

      newEntries.add(
        MapEntry<Country, List<VisaInformation>>(newCountry, entry.value),
      );
    }
    return VisaMatrix(
      matrix: Map.fromEntries(newEntries),
    );
  }

  List<Country> getCountriesByRequirement({
    required Country targetCountry,
    required VisaRequirementType requirementType,
  }) {
    final List<VisaInformation>? visaInformationList = matrix[targetCountry];

    return visaInformationList
            ?.where(
              (information) => information.requirement.type == requirementType,
            )
            .map((information) => information.destinationCountry.iso3code)
            .map((String isoCode) => isoToCountryMap[isoCode])
            .whereType<Country>()
            .toList() ??
        [];
  }

  Map<VisaRequirementType, List<Country>> getCountriesGroupedByRequirement({
    required Country targetCountry,
  }) {
    final List<VisaInformation> visaInformationList =
        matrix[targetCountry] ?? [];

    final Map<VisaRequirementType, List<Country>> result = {};

    for (final VisaInformation information in visaInformationList) {
      final VisaRequirementType type = information.requirement.type;

      final Country destinationCountry = information.destinationCountry;

      final List<Country> currentList = result[type] ?? [];
      currentList.add(destinationCountry);

      result[type] = currentList
          .map(
            (Country country) => isoToCountryMap[country.iso3code],
          )
          .whereType<Country>()
          .toList();
    }

    return result;
  }
}
