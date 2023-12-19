import 'package:passport_hub/common/api/visa_api.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';

class VisaRepository {
  final VisaApi visaApi;

  VisaRepository(this.visaApi);

  Future<VisaMatrix> generateVisaMatrix() async {
    final List<List<dynamic>>? rows = await visaApi.fetchVisaMatrix();

    if (rows == null) {
      throw Exception("Could not find rows!");
    }

    final Map<Country, List<VisaInformation>> result = {};

    for (int i = 1; i < rows.length; i++) {
      final String? currentCountryCode = rows[i][0] as String?;

      final Country country = Country(iso3code: currentCountryCode ?? "-");
      final List<VisaInformation> visaInformationList = [];

      for (int j = 1; j < rows[i].length; j++) {
        final String? targetCountryCode = rows[0][j] as String?;

        final dynamic current = rows[i][j] as dynamic;

        if (current == -1 || current == "-1") {
          continue;
        }

        final info = VisaInformation(
          destinationCountry: Country(iso3code: targetCountryCode ?? "-"),
          requirement: VisaRequirement.fromValue(current),
        );

        visaInformationList.add(info);
      }

      if (visaInformationList.isNotEmpty) {
        result[country] = visaInformationList;
      }
    }
    return VisaMatrix(
      matrix: result,
    );
  }
}
