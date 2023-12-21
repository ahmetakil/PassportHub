import 'package:passport_hub/common/api/country_list_api.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/country.dart';

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

        final String? countryName = rows[i][0] as String?;
        final String? iso2 = rows[i][1] as String?;
        final String? iso3 = rows[i][2] as String?;
        final String? region = rows[i][5] as String?;
        final String? subRegion = rows[i][6] as String?;

        if (iso3 == null) {
          HubLogger.e("iso3 is null for i: $i name: $countryName");
          continue;
        }

        result[iso3] = Country(
          iso3code: iso3,
          iso2code: iso2,
          name: countryName,
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
