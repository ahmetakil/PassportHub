import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passport_hub/common/api/mock_visa_api.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';

const _exampleData = """
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ///
  /// The country names will be used as iso3 because the example data is using names.
  const afghanistan = Country(
    iso3code: "Afghanistan",
    iso2code: "AF",
    region: "Asia",
    subRegion: "Southern Asia",
  );

  const albania = Country(
    iso3code: "Albania",
    iso2code: "AL",
    region: "Europe",
    subRegion: "Southern Europe",
  );

  const algeria = Country(
    iso3code: "Algeria",
    iso2code: "DZ",
    region: "Africa",
    subRegion: "Northern Africa",
  );

  const andorra = Country(
    iso3code: "Andorra",
    iso2code: "AD",
    region: "Europe",
    subRegion: "Southern Europe",
  );

  const angola = Country(
    iso3code: "Angola",
    iso2code: "AO",
    region: "Africa",
    subRegion: "Sub-Saharan Africa",
  );

  final countryData = <Country>[afghanistan, albania, algeria, andorra, angola];

  final visaApi = MockVisaApi(mockResponseData: _exampleData);
  late VisaRepository visaRepository;
  late VisaMatrix matrix;

  setUpAll(() async {
    visaRepository = VisaRepository(visaApi);
    matrix = await visaRepository.generateVisaMatrix();
  });

  blocTest<CountrySearchBloc, CountrySearchState>(
    'When country name Andorra is searched it will be the first matched result',
    build: () {
      return CountrySearchBloc()
        ..add(
          SetCountryList(
            matrix: matrix,
          ),
        );
    },
    act: (bloc) => bloc
      ..add(
        const CountrySearchQueryEvent(searchQuery: "Andorra"),
      ),
    expect: () => <CountrySearchState>[
      const CountrySearchResultsState(
        results: [
          andorra,
        ],
        searchQuery: "",
      ),
    ],
  );

  blocTest<CountrySearchBloc, CountrySearchState>(
    'When country name Afghanistan is searched it will be the first matched result',
    build: () {
      return CountrySearchBloc()
        ..add(
          SetCountryList(
            matrix: matrix,
          ),
        );
    },
    act: (bloc) => bloc
      ..add(
        const CountrySearchQueryEvent(searchQuery: "Afghanistan"),
      ),
    expect: () => <CountrySearchState>[
      const CountrySearchResultsState(
        results: [
          afghanistan,
        ],
        searchQuery: "",
      ),
    ],
  );

  blocTest<CountrySearchBloc, CountrySearchState>(
    'When country name Afghanistan is searched and then an empty query is searched state will go back to the initial state',
    build: () {
      return CountrySearchBloc()
        ..add(
          SetCountryList(
            matrix: matrix,
          ),
        );
    },
    act: (bloc) async {
      bloc.add(
        const CountrySearchQueryEvent(searchQuery: "Afghanistan"),
      );

      await Future.delayed(const Duration(milliseconds: 10));

      bloc.add(
        const CountrySearchQueryEvent(searchQuery: ""),
      );

      return bloc;
    },
    expect: () => <CountrySearchState>[
      const CountrySearchResultsState(
        searchQuery: "",
        results: [
          afghanistan,
        ],
      ),
      const CountrySearchInitialState(),
    ],
  );

  blocTest<CountrySearchBloc, CountrySearchState>(
    'When country iso AFG is searched it will find the country Afghanistan',
    build: () {
      return CountrySearchBloc()
        ..add(
          SetCountryList(
            matrix: matrix,
          ),
        );
    },
    act: (bloc) async {
      bloc.add(
        const CountrySearchQueryEvent(searchQuery: "Afghanistan"),
      );

      return bloc;
    },
    expect: () => <CountrySearchState>[
      const CountrySearchResultsState(
        results: [
          afghanistan,
        ],
        searchQuery: "",
      ),
    ],
  );
}
