part of 'compare_bloc.dart';

abstract class CompareEvent extends Equatable {
  const CompareEvent();
}

class CompareSearchQueryEvent extends CompareEvent {
  final String searchQuery;

  const CompareSearchQueryEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class SelectCountryForCompareEvent extends CompareEvent {
  final Country country;

  const SelectCountryForCompareEvent({
    required this.country,
  });

  @override
  List<Object> get props => [country];
}

class SetCompareCountryList extends CompareEvent {
  final VisaMatrix matrix;

  const SetCompareCountryList({
    required this.matrix,
  });

  @override
  List<Object> get props => [matrix];
}
