import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/country.dart';

part 'country_search_event.dart';

part 'country_search_state.dart';

class CountrySearchBloc extends Bloc<CountrySearchEvent, CountrySearchState> {
  final List<Country> allCountryList;

  late Fuzzy<Country> fuzzy;

  CountrySearchBloc({required this.allCountryList})
      : super(
          const CountrySearchInitialState(),
        ) {
    fuzzy = Fuzzy<Country>(
      allCountryList,
      options: FuzzyOptions<Country>(
        threshold: 0.8,
        keys: [
          WeightedKey(
            name: 'name',
            getter: (Country c) => c.name ?? '',
            weight: 5,
          ),
          WeightedKey(
            name: 'iso',
            getter: (Country c) => c.iso3code,
            weight: 6,
          ),
          WeightedKey(
            name: 'region',
            getter: (Country c) => c.subRegion ?? '',
            weight: 1,
          ),
        ],
      ),
    );

    on<CountrySearchEvent>((event, emit) {
      final String query = event.searchQuery;
      HubLogger.log("Searching for $query");

      if (query.isEmpty) {
        emit(const CountrySearchInitialState());
        return;
      }

      final List<Result<Country>> fuzzyResults = fuzzy.search(
        query,
        8,
      );

      final List<Country> matchedCountries =
          fuzzyResults.map((e) => e.item).toList();

      emit(
        CountrySearchResultsState(results: matchedCountries),
      );
    });
  }
}
