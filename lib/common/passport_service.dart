import 'package:collection/collection.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';

class PassportService {
  late final Map<Country, List<VisaInformation>> _destinations;

  PassportService(this._destinations);

  VisaRequirement findVisaRequirements(Country from, Country to) {
    final List<VisaInformation>? visaInfos = _destinations[from];
    final VisaInformation? visaInfo = visaInfos?.firstWhereOrNull(
      (info) => info.destinationCountry == to,
    );

    if (visaInfo != null) {
      return visaInfo.requirement;
    }
    return const VisaRequirement(
      type: VisaRequirementType.none,
    );
  }
}
