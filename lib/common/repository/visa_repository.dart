import 'package:passport_hub/common/api/visa_api.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';

class VisaRepository {
  final VisaApi visaApi;

  VisaRepository(this.visaApi);

  Future<Map<Country, List<VisaInformation>>> generateVisaMatrix() async {
    final List<List<dynamic>> data = await visaApi.fetchVisaMatrix();

    return {};
  }
}
