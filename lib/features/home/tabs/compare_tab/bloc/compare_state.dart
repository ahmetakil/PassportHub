part of 'compare_bloc.dart';

extension CompareStateExtension on CompareState {
  int get selectedCountryCount => selectedCountryList.length;
}

class CompareState extends Equatable {
  final List<Country> results;
  final List<Country> selectedCountryList;
  final String? searchQuery;

  const CompareState.initial()
      : searchQuery = null,
        results = const [],
        selectedCountryList = const [];

  const CompareState({
    required this.results,
    required this.selectedCountryList,
    required this.searchQuery,
  });

  @override
  List<Object> get props => [results, selectedCountryList, searchQuery ?? ""];

  CompareState copyWith({
    List<Country>? results,
    List<Country>? selectedCountryList,
    String? searchQuery,
  }) {
    return CompareState(
      results: results ?? this.results,
      selectedCountryList: selectedCountryList ?? this.selectedCountryList,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
