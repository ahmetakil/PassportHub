part of 'country_search_bloc.dart';

abstract class CountrySearchEvent {
  const CountrySearchEvent();
}

class SetCountryList extends CountrySearchEvent {
  final List<Country> allCountryList;

  const SetCountryList({
    required this.allCountryList,
  });
}

class CountrySearchQueryEvent extends CountrySearchEvent {
  final String searchQuery;

  const CountrySearchQueryEvent({required this.searchQuery});
}

class SelectCountryEvent extends CountrySearchEvent {
  final Country country;

  const SelectCountryEvent({required this.country});
}

class ClearSearchEvent extends CountrySearchEvent {
  const ClearSearchEvent();
}
