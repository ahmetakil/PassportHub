import 'package:flutter_test/flutter_test.dart';
import 'package:passport_hub/common/api/github_visa_api.dart';
import 'package:passport_hub/common/api/mock_visa_api.dart';
import 'package:passport_hub/common/api/visa_api.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';

const exampleData = """
Passport,Albania,Algeria,Andorra,Angola,Antigua and Barbuda,Argentina,Armenia
Afghanistan,e-visa,visa required,visa required,visa required,e-visa,visa required,visa required
Albania,-1,e-visa,90,visa required,180,visa required,180
Test,-1,visa free,90,visa required,180,visa required,visa on arrival
Japan,180,180,visa free,180,180,180,180
Algeria,e-visa,visa required,visa required,visa required,e-visa,visa required,visa required
Andorra,e-visa,visa required,visa required,visa required,e-visa,visa required,visa required
Armenia,e-visa,visa required,visa required,visa required,e-visa,visa required,visa required
Angola,e-visa,visa required,visa required,visa required,e-visa,visa required,visa required
Antigua and Barbuda,e-visa,visa required,visa required,visa required,e-visa,visa required,visa required
Argentina,e-visa,visa required,visa required,visa required,e-visa,visa required,visa required
""";

const Country albania = Country(iso3code: "Albania");
const Country angola = Country(iso3code: "Angola");
const Country algeria = Country(iso3code: "Algeria");
const Country andorra = Country(iso3code: "Andorra");
const Country armenia = Country(iso3code: "Armenia");
const Country afghanistan = Country(iso3code: "Afghanistan");
const Country testCountry = Country(iso3code: "Test");
const Country japan = Country(iso3code: "Japan");
const Country antigua = Country(iso3code: "Antigua and Barbuda");
const Country argentina = Country(iso3code: "Argentina");

const totalCountryCount = 7;

void main() {
  group('getCountriesGroupedByRequirement tests', () {
    final visaApi = MockVisaApi(mockResponseData: exampleData);
    late VisaRepository visaRepository;
    late VisaMatrix visaMatrix;

    setUp(() async {
      visaRepository = VisaRepository(visaApi);
      visaMatrix = await visaRepository.generateVisaMatrix();
    });

    test(
        'VisaMatrix correctly groups countries by visa requirement for Albania',
        () async {
      expect(visaMatrix, isNotNull);

      final Map<VisaRequirementType, List<Country>> result =
          visaMatrix.getCountriesGroupedByRequirement(
        targetCountry: albania,
      );

      expect(result.isNotEmpty, isTrue);
      expect(result.keys.length == 3, isTrue);
      expect(
        result[VisaRequirementType.eVisa],
        containsAllInOrder([algeria]),
      );
      expect(
        result[VisaRequirementType.visaFree],
        containsAllInOrder([andorra, antigua, armenia]),
      );
      expect(
        result[VisaRequirementType.visaRequired],
        containsAllInOrder([angola, argentina]),
      );

      expect(
        result.values.toList().length == result.values.toSet().length,
        isTrue,
      );
    });

    test('VisaMatrix correctly groups countries by visa requirement for Japan',
        () async {
      final Map<VisaRequirementType, List<Country>> result =
          visaMatrix.getCountriesGroupedByRequirement(
        targetCountry: japan,
      );

      expect(result.isNotEmpty, isTrue);
      expect(result.keys.length == 1, isTrue);

      expect(
        result[VisaRequirementType.visaFree],
        containsAllInOrder(
          [albania, algeria, andorra, angola, antigua, argentina, armenia],
        ),
      );

      expect(
        result.values.toList().length == result.values.toSet().length,
        isTrue,
      );
    });
  });

  group('getMinimumTravelAreaForCountries tests', () {
    final visaApi = MockVisaApi(mockResponseData: exampleData);
    late VisaRepository visaRepository;
    late VisaMatrix visaMatrix;

    setUp(() async {
      visaRepository = VisaRepository(visaApi);
      visaMatrix = await visaRepository.generateVisaMatrix();
    });

    test(
        'VisaMatrix correctly calculates minimum travel area for Japan and Albania',
        () async {
      expect(visaMatrix, isNotNull);

      final Map<VisaRequirementType, List<Country>> result =
          visaMatrix.getMinimumTravelAreaForCountries(
        targetCountries: [japan, albania],
      );

      expect(result.isNotEmpty, isTrue);
      expect(
        result[VisaRequirementType.visaFree],
        orderedEquals([
          albania,
          andorra,
          armenia,
          antigua,
        ]),
      );
    });

    test('VisaMatrix correctly calculates minimum travel area for Japan',
        () async {
      expect(visaMatrix, isNotNull);

      final Map<VisaRequirementType, List<Country>> result =
          visaMatrix.getMinimumTravelAreaForCountries(
        targetCountries: [japan],
      );

      expect(result.isNotEmpty, isTrue);
      expect(
        result[VisaRequirementType.visaFree],
        orderedEquals([
          albania,
          japan,
          algeria,
          andorra,
          armenia,
          angola,
          antigua,
          argentina,
        ]),
      );

      expect(
        result[VisaRequirementType.visaRequired],
        orderedEquals([afghanistan, testCountry]),
      );
    });

    test('VisaMatrix correctly calculates minimum travel area for Japan',
        () async {
      expect(visaMatrix, isNotNull);

      final Map<VisaRequirementType, List<Country>> result =
          visaMatrix.getMinimumTravelAreaForCountries(
        targetCountries: [],
      );

      expect(result.isEmpty, isTrue);
    });
  });

  group('getPassportRankingsWithVisaFreeCount tests', () {
    final visaApi = MockVisaApi(mockResponseData: exampleData);
    late VisaRepository visaRepository;
    late VisaMatrix visaMatrix;

    setUp(() async {
      visaRepository = VisaRepository(visaApi);
      visaMatrix = await visaRepository.generateVisaMatrix();
    });

    test('Tests calling passport rankings sorted list', () async {
      final Map<Country, int> result =
          visaMatrix.getPassportRankingsWithVisaFreeCount();

      expect(result.isNotEmpty, isTrue);

      final MapEntry<Country, int> firstEntry = result.entries.first;
      final MapEntry<Country, int> secondEntry = result.entries.toList()[1];
      final MapEntry<Country, int> lastEntry = result.entries.last;

      expect(firstEntry.value > secondEntry.value, isTrue);
      expect(firstEntry.value > lastEntry.value, isTrue);
      expect(secondEntry.value > lastEntry.value, isTrue);
    });
  });
}
