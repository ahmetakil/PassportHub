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
  final bool isUnselectable;

  const SelectCountryEvent({
    required this.country,
    this.isUnselectable = false,
  });
}

class ClearSearchEvent extends CountrySearchEvent {
  const ClearSearchEvent();
}

class SelectListFilterEvent extends CountrySearchEvent {
  final List<Country> targetCountryList;

  final CountryListFilterChipOptions option;
  final bool searchAfterFiltering;

  const SelectListFilterEvent({
    required this.option,
    required this.targetCountryList,
    this.searchAfterFiltering = true,
  });
}
