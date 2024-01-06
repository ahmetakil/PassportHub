part of 'country_search_bloc.dart';

extension CountrySearchStateExtension on CountrySearchState {
  /// We want to distinguish between an empty search results state
  /// and the initial state.
  List<Country>? getResultsOrEmpty() {
    if (this is CountrySearchInitialState) {
      return null;
    }

    if (this is CountrySearchResultsState) {
      final resultState = this as CountrySearchResultsState;

      return resultState.results;
    }

    return [];
  }

  List<Country> getSelectedCountryList() {
    if (this is CountrySearchResultsState) {
      final resultState = this as CountrySearchResultsState;

      return resultState.selectedCountryList;
    }

    return [];
  }
}

sealed class CountrySearchState extends Equatable {
  final CountryListFilterChipOptions selectedFilterOption;

  const CountrySearchState({
    this.selectedFilterOption = CountryListFilterChipOptions.all,
  });

  CountrySearchState copyWith({
    CountryListFilterChipOptions? selectedFilterOption,
  });

  @override
  List<Object?> get props => [selectedFilterOption];
}

class CountrySearchInitialState extends CountrySearchState {
  const CountrySearchInitialState({
    CountryListFilterChipOptions? selectedFilterOption,
  }) : super(
          selectedFilterOption:
              selectedFilterOption ?? CountryListFilterChipOptions.all,
        );

  @override
  CountrySearchInitialState copyWith({
    CountryListFilterChipOptions? selectedFilterOption,
  }) {
    return CountrySearchInitialState(
      selectedFilterOption: selectedFilterOption ?? this.selectedFilterOption,
    );
  }

  @override
  List<Object?> get props => [selectedFilterOption];
}

class CountrySearchResultsState extends CountrySearchState {
  final List<Country> results;
  final List<Country> selectedCountryList;
  final String searchQuery;

  const CountrySearchResultsState({
    required this.results,
    this.selectedCountryList = const [],
    CountryListFilterChipOptions? selectedFilterOption,
    required this.searchQuery,
  }) : super(
          selectedFilterOption:
              selectedFilterOption ?? CountryListFilterChipOptions.all,
        );

  @override
  List<Object?> get props =>
      [results, selectedCountryList, selectedFilterOption];

  @override
  CountrySearchResultsState copyWith({
    List<Country>? results,
    List<Country>? selectedCountryList,
    CountryListFilterChipOptions? selectedFilterOption,
    String? searchQuery,
  }) {
    return CountrySearchResultsState(
      results: results ?? this.results,
      selectedCountryList: selectedCountryList ?? this.selectedCountryList,
      selectedFilterOption: selectedFilterOption ?? this.selectedFilterOption,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
