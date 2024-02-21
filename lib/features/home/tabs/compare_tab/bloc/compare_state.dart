part of 'compare_bloc.dart';

extension CompareStateExtension on CompareState {
  List<Country>? getResultsOrEmpty() {
    if (this is CompareInitialState) {
      return null;
    }

    if (this is CompareResultState) {
      final resultState = this as CompareResultState;

      return resultState.results;
    }

    return [];
  }

  bool getIsSelected(Country country) {
    return getSelectedCompareList().contains(country);
  }

  List<Country> getSelectedCompareList() {
    if (this is CompareResultState) {
      final resultState = this as CompareResultState;

      return resultState.selectedCountryList;
    }

    return [];
  }
}

sealed class CompareState extends Equatable {
  const CompareState();

  CompareState copyWith();
}

class CompareInitialState extends CompareState {
  @override
  CompareInitialState copyWith() {
    return CompareInitialState();
  }

  @override
  List<Object> get props => [];
}

class CompareResultState extends CompareState {
  final List<Country> results;
  final List<Country> selectedCountryList;
  final String searchQuery;

  const CompareResultState({
    required this.results,
    required this.selectedCountryList,
    required this.searchQuery,
  });

  @override
  List<Object> get props => [results, selectedCountryList, searchQuery];

  @override
  CompareResultState copyWith({
    List<Country>? results,
    List<Country>? selectedCountryList,
    String? searchQuery,
  }) {
    return CompareResultState(
      results: results ?? this.results,
      selectedCountryList: selectedCountryList ?? this.selectedCountryList,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
