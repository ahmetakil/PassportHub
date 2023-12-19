import 'package:collection/collection.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';

class VisaMatrix {
  final Map<Country, List<VisaInformation>> matrix;

  VisaMatrix({required this.matrix});

  VisaInformation? getVisaInformation({
    required Country from,
    required Country to,
  }) {
    return matrix[from]?.firstWhereOrNull(
      (VisaInformation target) => target.destinationCountry == to,
    );
  }
}
