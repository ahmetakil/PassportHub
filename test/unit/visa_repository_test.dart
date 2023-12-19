import 'package:flutter_test/flutter_test.dart';
import 'package:passport_hub/common/api/mock_visa_api.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';

const exampleData = """
Passport,Albania,Algeria,Andorra,Angola,Antigua and Barbuda,Argentina,Armenia
Afghanistan,e-visa,visa required,visa required,visa required,e-visa,visa required,visa required
Albania,-1,visa required,90,visa required,180,visa required,180
Test,-1,visa free,90,visa required,180,visa required,visa on arrival""";

const Country albania = Country(name: "Albania");
const Country armenia = Country(name: "Armenia");
const Country afghanistan = Country(name: "Afghanistan");
const Country algeria = Country(name: "Algeria");
const Country testCountry = Country(name: "Test");

void main() {
  group('Visa Repository Tests', () {
    final visaApi = MockVisaApi(mockResponseData: exampleData);
    late VisaRepository visaRepository;

    setUp(() {
      visaRepository = VisaRepository(visaApi);
    });

    test('Given the VisaMatrix Afghanistan -> Albania will return evisa',
        () async {
      final VisaMatrix visaMatrix = await visaRepository.generateVisaMatrix();

      expect(visaMatrix, isNotNull);

      expect(
        visaMatrix
            .getVisaInformation(from: afghanistan, to: albania)!
            .requirement,
        const VisaRequirement(
          type: VisaRequirementType.eVisa,
        ),
      );
    });

    test(
        'Given the VisaMatrix Afghanistan -> Armenia will return visa required',
        () async {
      final VisaMatrix visaMatrix = await visaRepository.generateVisaMatrix();

      expect(visaMatrix, isNotNull);

      final Country afghanistan = visaMatrix.matrix.keys.first;

      expect(
        visaMatrix
            .getVisaInformation(from: afghanistan, to: armenia)!
            .requirement,
        const VisaRequirement(
          type: VisaRequirementType.visaRequired,
        ),
      );
    });

    test('Given the VisaMatrix Albania -> Armenia will return evisa', () async {
      final VisaMatrix visaMatrix = await visaRepository.generateVisaMatrix();

      expect(visaMatrix, isNotNull);

      expect(
        visaMatrix.getVisaInformation(from: albania, to: armenia)!.requirement,
        const VisaRequirement(
          type: VisaRequirementType.visaFree,
          daysAllowed: 180,
        ),
      );
    });

    test('Given the VisaMatrix Albania -> Albania no entry will be found',
        () async {
      final VisaMatrix visaMatrix = await visaRepository.generateVisaMatrix();

      expect(visaMatrix, isNotNull);

      expect(
        visaMatrix.getVisaInformation(from: albania, to: albania),
        isNull,
      );
    });

    test('Given the VisaMatrix Test -> Armenia, visa on arrival will be found',
        () async {
      final VisaMatrix visaMatrix = await visaRepository.generateVisaMatrix();

      expect(visaMatrix, isNotNull);

      expect(
        visaMatrix
            .getVisaInformation(from: testCountry, to: armenia)!
            .requirement,
        const VisaRequirement(
          type: VisaRequirementType.visaOnArrival,
        ),
      );
    });

    test('Given the VisaMatrix Test -> Algeria, visa on arrival will be found',
        () async {
      final VisaMatrix visaMatrix = await visaRepository.generateVisaMatrix();

      expect(visaMatrix, isNotNull);

      expect(
        visaMatrix
            .getVisaInformation(from: testCountry, to: algeria)!
            .requirement,
        const VisaRequirement(
          type: VisaRequirementType.visaFree,
        ),
      );
    });
  });
}
