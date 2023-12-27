part of 'country_search_bloc.dart';

abstract class CountrySearchEvent {
  const CountrySearchEvent();
}

class CountrySearchQueryEvent extends CountrySearchEvent {
  final String searchQuery;

  const CountrySearchQueryEvent({required this.searchQuery});
}

class SelectCountryEvent extends CountrySearchEvent {
  final Country country;

  const SelectCountryEvent({required this.country});
}
