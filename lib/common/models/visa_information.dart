import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';

class VisaInformation {
  final Country destinationCountry;
  final VisaRequirement requirement;

  VisaInformation({
    required this.destinationCountry,
    required this.requirement,
  });
}
