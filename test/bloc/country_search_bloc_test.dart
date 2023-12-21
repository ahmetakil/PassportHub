import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/features/home/bloc/country_search_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const afghanistan = Country(
    iso3code: "AFG",
    iso2code: "AF",
    name: "Afghanistan",
    region: "Asia",
    subRegion: "Southern Asia",
  );

  const albania = Country(
    iso3code: "ALB",
    iso2code: "AL",
    name: "Albania",
    region: "Europe",
    subRegion: "Southern Europe",
  );

  const algeria = Country(
    iso3code: "DZA",
    iso2code: "DZ",
    name: "Algeria",
    region: "Africa",
    subRegion: "Northern Africa",
  );

  const andorra = Country(
    iso3code: "AND",
    iso2code: "AD",
    name: "Andorra",
    region: "Europe",
    subRegion: "Southern Europe",
  );

  const angola = Country(
    iso3code: "AGO",
    iso2code: "AO",
    name: "Angola",
    region: "Africa",
    subRegion: "Sub-Saharan Africa",
  );

  final countryData = <Country>[afghanistan, albania, algeria, andorra, angola];

  blocTest<CountrySearchBloc, CountrySearchState>(
    'When country name Andorra is searched it will be the first matched result',
    build: () {
      return CountrySearchBloc(
        allCountryList: countryData,
      );
    },
    act: (bloc) => bloc
      ..add(
        CountrySearchEvent(searchQuery: "Andorra"),
      ),
    expect: () => <CountrySearchState>[
      const CountrySearchResultsState(
        results: [
          andorra,
          algeria,
          angola,
        ],
      ),
    ],
  );

  blocTest<CountrySearchBloc, CountrySearchState>(
    'When country name Afghanistan is searched it will be the first matched result',
    build: () {
      return CountrySearchBloc(
        allCountryList: countryData,
      );
    },
    act: (bloc) => bloc
      ..add(
        CountrySearchEvent(searchQuery: "Afghanistan"),
      ),
    expect: () => <CountrySearchState>[
      const CountrySearchResultsState(
        results: [
          afghanistan,
          albania,
          angola,
        ],
      ),
    ],
  );

  blocTest<CountrySearchBloc, CountrySearchState>(
    'When country name Afghanistan is searched and then an empty query is searched state will go back to the initial state',
    build: () {
      return CountrySearchBloc(
        allCountryList: countryData,
      );
    },
    act: (bloc) async {
      bloc.add(
        CountrySearchEvent(searchQuery: "Afghanistan"),
      );

      await Future.delayed(const Duration(milliseconds: 10));

      bloc.add(
        CountrySearchEvent(searchQuery: ""),
      );

      return bloc;
    },
    expect: () => <CountrySearchState>[
      const CountrySearchResultsState(
        results: [
          afghanistan,
          albania,
          angola,
        ],
      ),
      const CountrySearchInitialState(),
    ],
  );

  blocTest<CountrySearchBloc, CountrySearchState>(
    'When country iso AFG is searched it will find the country Afghanistan',
    build: () {
      return CountrySearchBloc(
        allCountryList: countryData,
      );
    },
    act: (bloc) async {
      bloc.add(
        CountrySearchEvent(searchQuery: "AFG"),
      );

      return bloc;
    },
    expect: () => <CountrySearchState>[
      const CountrySearchResultsState(
        results: [
          afghanistan,
          angola,
          algeria,
        ],
      ),
    ],
  );
}
