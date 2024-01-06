part of 'country_search_bloc.dart';

abstract class CountrySearchEvent {
  const CountrySearchEvent();
}

class SetCountryList extends CountrySearchEvent {
  final VisaMatrix matrix;

  const SetCountryList({
    required this.matrix,
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

class SelectListFilterEvent extends CountrySearchEvent {
  final Country targetCountry;

  final CountryListFilterChipOptions option;

  const SelectListFilterEvent({
    required this.option,
    required this.targetCountry,
  });
}
