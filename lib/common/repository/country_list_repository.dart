import 'package:passport_hub/common/api/country_list_api.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/country.dart';

const Map<String, String> _nameUpdates = {
  'United Kingdom of Great Britain and Northern Ireland': 'United Kingdom',
};

String? updateName(String? name) {
  if (_nameUpdates.containsKey(name)) {
    return _nameUpdates[name];
  }
  return name?.replaceAll('"', "");
}

class CountryListRepository {
  final CountryListApi countryListApi;

  CountryListRepository(this.countryListApi);

  Future<Map<String, Country>> generateCountryListMatrix() async {
    final List<List<dynamic>>? rows = await countryListApi.fetchCountryList();

    if (rows == null) {
      throw Exception("Could not find rows!");
    }

    final Map<String, Country> result = {};

    for (int i = 1; i < rows.length; i++) {
      try {
        if (rows[i].length < 6) {
          continue;
        }

        late List currentRow;

        if (rows[i].length == 12) {
          currentRow = [
            "${rows[i][0]}${rows[i][1]}",
            ...rows[i].sublist(2),
          ];
        } else {
          currentRow = rows[i];
        }

        final String? countryName = currentRow[0] as String?;
        final String? iso2 = currentRow[1] as String?;
        final String? iso3 = currentRow[2] as String?;
        final String? region = currentRow[5] as String?;
        final String? subRegion = currentRow[6] as String?;

        if (iso3 == null) {
          HubLogger.e("iso3 is null for i: $i name: $countryName");
          continue;
        }

        result[iso3] = Country(
          iso3code: iso3,
          iso2code: iso2,
          name: updateName(countryName),
          region: region,
          subRegion: subRegion,
        );
      } catch (e, stacktrace) {
        HubLogger.e(
          'CountryListRepository.generateCountryListMatrix e: $e',
          stackTrace: stacktrace,
        );
      }
    }

    return result;
  }
}
