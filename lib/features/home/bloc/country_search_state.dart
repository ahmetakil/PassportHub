part of 'country_search_bloc.dart';

sealed class CountrySearchState extends Equatable {
  const CountrySearchState();
}

class CountrySearchInitialState extends CountrySearchState {
  const CountrySearchInitialState();

  @override
  List<Object?> get props => [];
}

class CountrySearchResultsState extends CountrySearchState {
  final List<Country> results;

  final List<Country> selectedCountryList;

  const CountrySearchResultsState({
    required this.results,
    this.selectedCountryList = const [],
  });

  @override
  List<Object?> get props => [results, selectedCountryList];

  CountrySearchResultsState copyWith({
    List<Country>? results,
    List<Country>? selectedCountryList,
  }) {
    return CountrySearchResultsState(
      results: results ?? this.results,
      selectedCountryList: selectedCountryList ?? this.selectedCountryList,
    );
  }
}
