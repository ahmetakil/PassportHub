import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/country.dart';

part 'country_search_event.dart';

part 'country_search_state.dart';

class CountrySearchBloc extends Bloc<CountrySearchEvent, CountrySearchState> {
  late List<Country> allCountryList;

  Fuzzy<Country>? fuzzy;

  CountrySearchBloc()
      : super(
          const CountrySearchInitialState(),
        ) {
    on<SetCountryList>((event, emit) {
      allCountryList = event.allCountryList;
      fuzzy = Fuzzy<Country>(
        allCountryList,
        options: FuzzyOptions<Country>(
          shouldNormalize: true,
          threshold: 0.8,
          distance: 50,
          keys: [
            WeightedKey(
              name: 'name',
              getter: (Country c) => c.name ?? '',
              weight: 3,
            ),
          ],
        ),
      );
    });

    on<CountrySearchQueryEvent>((event, emit) {
      final String query = event.searchQuery;
      HubLogger.log("Searching for $query");

      if (query.isEmpty) {
        emit(const CountrySearchInitialState());
        return;
      }

      final Fuzzy<Country>? fuzzySearch = fuzzy;

      if (fuzzySearch == null) {
        HubLogger.e(
          "Could not find fuzzy, make sure to call SetCountryList first ",
        );
        return;
      }

      final List<Result<Country>> fuzzyResults = fuzzySearch.search(
        query,
      );

      final Country? exactMatchedIso = allCountryList
          .firstWhereOrNull((Country country) => country.iso3code == query);

      final List<Country> matchedCountries =
          fuzzyResults.map((e) => e.item).toList();

      if (exactMatchedIso != null) {
        matchedCountries.removeWhere(
          (Country country) => country.iso3code == query,
        );
        matchedCountries.insert(0, exactMatchedIso);
      }

      final List<Country> alreadySelectedCountryList =
          state.getSelectedCountryList();

      if (alreadySelectedCountryList.isNotEmpty) {
        matchedCountries
            .removeWhere((Country c) => alreadySelectedCountryList.contains(c));
        matchedCountries.insertAll(0, alreadySelectedCountryList);
      }

      emit(
        CountrySearchResultsState(
          results: matchedCountries,
          selectedCountryList: state.getSelectedCountryList(),
        ),
      );
    });

    on<SelectCountryEvent>((event, emit) {
      if (state is CountrySearchResultsState) {
        final resultState = state as CountrySearchResultsState;

        final List<Country> selectedCountryList = [
          ...resultState.selectedCountryList,
        ];

        if (selectedCountryList.contains(event.country)) {
          selectedCountryList.remove(event.country);
        } else {
          selectedCountryList.add(event.country);
        }

        emit(
          resultState.copyWith(
            selectedCountryList: selectedCountryList,
          ),
        );
      }
    });
  }
}
