import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/features/country_details/widgets/country_list_filter_chips.dart';

part 'country_search_event.dart';

part 'country_search_state.dart';

///
/// CountrySearchBloc:
/// There will be different instances of CountrySearchBloc scopes at different levels.
/// Since TravelTab and SearchScreen need to pass through events to, they will use the globally accessible one
/// But for ExploreTab it will have it's own SearchBloc same as CountryDetails.
class CountrySearchBloc extends Bloc<CountrySearchEvent, CountrySearchState> {
  late List<Country> allCountryList;
  late VisaMatrix matrix;

  late Map<VisaRequirementType, List<Country>> requirementTypesMap;

  List<Country> filteredCountryList = [];

  Fuzzy<Country>? fuzzy;

  final FuzzyOptions<Country> fuzzyOptions = FuzzyOptions<Country>(
    shouldNormalize: true,
    threshold: 0.4,
    distance: 50,
    keys: [
      WeightedKey(
        name: 'name',
        getter: (Country c) => c.name ?? '',
        weight: 3,
      ),
    ],
  );

  CountrySearchBloc()
      : super(
          const CountrySearchInitialState(),
        ) {
    on<SetCountryList>((event, emit) {
      matrix = event.matrix;

      allCountryList = matrix.countryList;

      fuzzy = Fuzzy<Country>(
        allCountryList,
        options: fuzzyOptions,
      );
    });

    on<CountrySearchQueryEvent>((event, emit) {
      final String query = event.searchQuery;
      HubLogger.log("Searching for $query");

      if (query.isEmpty) {
        emit(
          CountrySearchInitialState(
            selectedFilterOption: state.selectedFilterOption,
          ),
        );
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
          searchQuery: event.searchQuery,
          selectedFilterOption: state.selectedFilterOption,
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

    on<ClearSearchEvent>((event, emit) {
      emit(
        CountrySearchInitialState(
          selectedFilterOption: state.selectedFilterOption,
        ),
      );
    });

    on<SelectListFilterEvent>((event, emit) {
      final List<Country> filteredCountries = _applyFilter(
            option: event.option,
            targetCountry: event.targetCountry,
          ) ??
          [];

      emit(
        CountrySearchResultsState(
          results: filteredCountries,
          selectedCountryList: state.getSelectedCountryList(),
          selectedFilterOption: event.option,
          searchQuery: state is CountrySearchResultsState
              ? (state as CountrySearchResultsState).searchQuery
              : "",
        ),
      );

      final currentState = state;
      if (currentState is CountrySearchResultsState &&
          currentState.searchQuery.isNotEmpty) {
        fuzzy = Fuzzy<Country>(
          filteredCountries,
          options: fuzzyOptions,
        );

        add(
          CountrySearchQueryEvent(searchQuery: currentState.searchQuery),
        );
      }
    });
  }

  List<Country>? _applyFilter({
    required CountryListFilterChipOptions option,
    required Country targetCountry,
  }) {
    final Map<VisaRequirementType, List<Country>> requirementsMap =
        matrix.getCountriesGroupedByRequirement(targetCountry: targetCountry);

    return switch (option) {
      CountryListFilterChipOptions.all => allCountryList,
      CountryListFilterChipOptions.visaFree =>
        requirementsMap[VisaRequirementType.visaFree],
      CountryListFilterChipOptions.visaOnArrival =>
        requirementsMap[VisaRequirementType.visaOnArrival],
      CountryListFilterChipOptions.eVisa =>
        requirementsMap[VisaRequirementType.eVisa],
      CountryListFilterChipOptions.visaRequired =>
        requirementsMap[VisaRequirementType.visaRequired],
    };
  }
}
