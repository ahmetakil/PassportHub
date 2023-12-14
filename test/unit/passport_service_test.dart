import 'package:flutter_test/flutter_test.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/passport_service.dart';

const Country canada = Country(name: "Canada", iso3code: "CAN");
const Country france = Country(name: "France", iso3code: "FRA");
const Country turkey = Country(name: "Turkey", iso3code: "TUR");

void main() {
  group('PassportService Tests', () {
    late Map<Country, List<VisaInformation>> mockDestinations;
    late PassportService passportService;

    setUp(() {
      mockDestinations = {
        canada: [
          VisaInformation(
            destinationCountry: france,
            requirement: const VisaRequirement.unlimited(),
          ),
          VisaInformation(
            destinationCountry: turkey,
            requirement: const VisaRequirement.unlimited(),
          ),
        ],
        france: [
          VisaInformation(
            destinationCountry: canada,
            requirement: const VisaRequirement.noEntry(),
          ),
          VisaInformation(
            destinationCountry: turkey,
            requirement: const VisaRequirement.unlimited(),
          ),
        ],
        turkey: [
          VisaInformation(
            destinationCountry: canada,
            requirement: const VisaRequirement.noEntry(),
          ),
          VisaInformation(
            destinationCountry: france,
            requirement: const VisaRequirement.noEntry(),
          ),
        ],
      };

      passportService = PassportService(mockDestinations);
    });

    test(
        'findVisaRequirements for Canada to France returns correct requirement',
        () {
      final VisaRequirement requirement =
          passportService.findVisaRequirements(canada, france);

      expect(requirement, const VisaRequirement.unlimited());
    });

    test(
        'findVisaRequirements for Canada to Turkey returns correct requirement',
        () {
      final VisaRequirement requirement =
          passportService.findVisaRequirements(canada, turkey);

      expect(requirement, const VisaRequirement.unlimited());
    });

    test('findVisaRequirements for France to Canada returns no entry', () {
      final VisaRequirement requirement =
          passportService.findVisaRequirements(france, canada);

      expect(requirement, const VisaRequirement.noEntry());
    });

    test('findVisaRequirements for Turkey to Canada returns no entry', () {
      final VisaRequirement requirement =
          passportService.findVisaRequirements(turkey, canada);

      expect(requirement, const VisaRequirement.noEntry());
    });

    test('findVisaRequirements for a non-existent route returns default value',
        () {
      const Country nonExistentCountry =
          Country(name: "Non-Existent Country", iso3code: "XXX");

      final VisaRequirement requirement =
          passportService.findVisaRequirements(canada, nonExistentCountry);

      expect(
        requirement,
        const VisaRequirement(
          type: VisaRequirementType.none,
        ),
      );
      expect(requirement.daysAllowed, null);
    });
  });
}
