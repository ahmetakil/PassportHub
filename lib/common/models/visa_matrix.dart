import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

typedef Iso3 = String;

class VisaMatrix {
  final Map<Country, List<VisaInformation>> matrix;

  late Map<Iso3, Country> isoToCountryMap;
  late Map<Country, int> passportRankingSortedList;

  VisaMatrix({required this.matrix})
      : isoToCountryMap = {
          for (final Country c in matrix.keys.toList()) c.iso3code: c,
        } {
    passportRankingSortedList = getPassportRankingsWithVisaFreeCount();
  }

  List<Country> get countryList => matrix.keys.toList();

  Country? getCountryByIso(String iso3) {
    return countryList.firstWhereOrNull(
      (Country country) => country.iso3code == iso3,
    );
  }

  VisaInformation? getVisaInformation({
    required Country from,
    required Country to,
  }) {
    return matrix[from]?.firstWhereOrNull(
      (VisaInformation target) => target.destinationCountry == to,
    );
  }

  VisaMatrix enhanceWithCountryList(Map<Iso3, Country> countryList) {
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

  /// For instance if there is targetCountry: [Country(A), Country(B)]
  /// This function will return a Map where visa-free will imply countries where both
  /// A and B can visit visa free.
  Map<VisaRequirementType, List<Country>> getMinimumTravelAreaForCountries({
    required List<Country> targetCountries,
  }) {
    if (targetCountries.isEmpty) {
      return {};
    }

    final Map<VisaRequirementType, List<Country>> result = {};

    for (final VisaRequirementType type in VisaRequirementType.values) {
      result[type] = [];
    }

    for (final destinationCountry in matrix.keys) {
      VisaRequirementType mostRestrictiveType = VisaRequirementType.visaFree;

      // Determine the most restrictive visa type for this destination
      for (final targetCountry in targetCountries) {
        if (targetCountry == destinationCountry) {
          // If the destination country is one of the target countries, it should always be included as visaFree
          mostRestrictiveType = VisaRequirementType.visaFree;
        } else {
          final visaInfoList = matrix[targetCountry] ?? [];
          final visaInfo = visaInfoList.firstWhere(
            (info) => info.destinationCountry == destinationCountry,
            orElse: () => VisaInformation(
              destinationCountry: destinationCountry,
              requirement: const VisaRequirement.noEntry(),
            ),
          );

          // Update the most restrictive type if necessary
          if (visaInfo.requirement.type.index > mostRestrictiveType.index) {
            mostRestrictiveType = visaInfo.requirement.type;
          }
        }
      }

      if (mostRestrictiveType != VisaRequirementType.none) {
        result[mostRestrictiveType]?.add(destinationCountry);
      }
    }

    result.removeWhere((key, value) => value.isEmpty);
    return result;
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

  Map<Country, VisaRequirementType> generateRequirementMapForCountryGroups({
    required List<Country> countryList,
  }) {
    final Map<VisaRequirementType, List<Country>> requirementMap =
        getMinimumTravelAreaForCountries(
      targetCountries: countryList,
    );

    final Map<Country, VisaRequirementType> countryToRequirementMap = {};

    for (final MapEntry<VisaRequirementType, List<Country>> entry
        in requirementMap.entries) {
      final type = entry.key;

      countryToRequirementMap.addAll(
        Map.fromIterable(
          entry.value,
          value: (_) => type,
        ),
      );
    }

    return countryToRequirementMap;
  }

  Map<String, Color> generateColorMapForCountryGroups({
    required List<Country> countryList,
  }) {
    final Map<Country, VisaRequirementType> countryToReqMap =
        generateRequirementMapForCountryGroups(countryList: countryList);

    countryToReqMap
        .removeWhere((Country country, _) => country.iso2code == null);

    final List<MapEntry<String, Color>> filteredMapEntries = countryToReqMap
        .map(
          (Country country, VisaRequirementType type) =>
              MapEntry(country.iso2code!.toLowerCase(), type.color),
        )
        .entries
        .toList();

    return Map.fromEntries(filteredMapEntries);
  }

  Map<String, Color> generateColorMapForCountryRequirements({
    required Country targetCountry,
    Color? selfColor,
  }) {
    final Map<VisaRequirementType, List<Country>> requirementMap =
        getCountriesGroupedByRequirement(
      targetCountry: targetCountry,
    );

    final Map<String, Color> mapColors = {};

    for (final MapEntry<VisaRequirementType, List<Country>> entry
        in requirementMap.entries) {
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

    final String selfIsoCode = targetCountry.iso2code?.toLowerCase() ?? "";

    mapColors[selfIsoCode] = selfColor ?? Colors.grey;
    return mapColors;
  }

  Map<Country, int> getPassportRankingsWithVisaFreeCount() {
    final Map<Country, double> mobilityScores = {};
    final Map<Country, int> visaFreeCounts = {};

    matrix.forEach((country, visaInfoList) {
      double score = 0;
      int visaFreeCount = 0;

      for (final visaInfo in visaInfoList) {
        score += visaInfo.requirement.type.score;

        if (visaInfo.requirement.type == VisaRequirementType.visaFree) {
          visaFreeCount++;
        }
      }

      mobilityScores[country] = score;
      visaFreeCounts[country] = visaFreeCount;
    });

    final sortedCountries = mobilityScores.keys.toList();
    sortedCountries.sort(
      (a, b) => mobilityScores[b]?.compareTo(mobilityScores[a] ?? 0) ?? 0,
    );

    final Map<Country, int> sortedVisaFreeCounts = {};
    for (final country in sortedCountries) {
      final int? visaFreeCount = visaFreeCounts[country];

      if (visaFreeCount != null) {
        sortedVisaFreeCounts[country] = visaFreeCount;
      }
    }

    return sortedVisaFreeCounts;
  }
}
