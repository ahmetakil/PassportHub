import 'package:collection/collection.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';

class VisaMatrix {
  final Map<Country, List<VisaInformation>> matrix;

  VisaMatrix({required this.matrix});

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

  Map<Country, double> calculatePassportPower() {
    return {};
  }
}
