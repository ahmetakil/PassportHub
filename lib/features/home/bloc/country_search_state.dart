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

  const CountrySearchResultsState({
    required this.results,
  });

  @override
  List<Object?> get props => [results];

  CountrySearchResultsState copyWith({
    List<Country>? results,
  }) {
    return CountrySearchResultsState(
      results: results ?? this.results,
    );
  }
}
