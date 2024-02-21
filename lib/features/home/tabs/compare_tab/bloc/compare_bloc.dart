import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:passport_hub/common/hub_fuzzy_search.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';

part 'compare_event.dart';

part 'compare_state.dart';

class CompareBloc extends Bloc<CompareEvent, CompareState> {
  late List<Country> allCountryList;
  late VisaMatrix matrix;

  final FuzzyOptions<Country> fuzzyOptions = getFuzzyOptions();

  Fuzzy<Country>? fuzzy;

  CompareBloc() : super(CompareInitialState()) {
    on<SetCompareCountryList>((event, emit) {
      matrix = event.matrix;

      allCountryList = matrix.countryList;

      fuzzy = Fuzzy<Country>(
        allCountryList,
        options: fuzzyOptions,
      );
    });

    on<CompareSearchQueryEvent>((event, emit) {
      HubLogger.log("> CompareSearchQueryEvent ${event.searchQuery}");

      final String query = event.searchQuery;

      if (query.isEmpty) {
        emit(
          CompareInitialState(),
        );
        return;
      }

      final Fuzzy<Country>? fuzzySearch = fuzzy;

      if (fuzzySearch == null) {
        return;
      }

      final List<Result<Country>> fuzzyResults = fuzzySearch.search(
        query,
      );

      final List<Country> matchedCountries =
          fuzzyResults.map((e) => e.item).toList();

      emit(
        CompareResultState(
          results: matchedCountries,
          selectedCountryList: state.getSelectedCompareList(),
          searchQuery: event.searchQuery,
        ),
      );
    });

    on<SelectCountryForCompareEvent>((event, emit) {
      HubLogger.log("> SelectCountryEvent ${event.country}");

      switch (state) {
        case CompareInitialState():
          emit(
            CompareInitialState(),
          );
        case CompareResultState():
          final resultState = state as CompareResultState;

          final List<Country> selectedCountryList = [
            ...resultState.selectedCountryList,
          ];

          if (selectedCountryList.contains(event.country)) {
            selectedCountryList.remove(event.country);
          } else {
            selectedCountryList.add(event.country);
          }

          emit(
            resultState.copyWith(
              selectedCountryList: selectedCountryList,
            ),
          );
      }
    });
  }
}