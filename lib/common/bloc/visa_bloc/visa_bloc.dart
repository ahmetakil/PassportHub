import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/repository/country_list_repository.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';

part 'visa_event.dart';

part 'visa_state.dart';

class VisaBloc extends Bloc<VisaEvent, VisaState> {
  final VisaRepository repository;
  final CountryListRepository countryListRepository;

  VisaBloc(this.repository, this.countryListRepository)
      : super(const VisaState()) {
    on<FetchMatrixEvent>((event, emit) async {
      emit(
        state.copyWith(isLoading: true),
      );

      try {
        HubLogger.log("Generating visa matrix");
        final VisaMatrix visaMatrix = await repository.generateVisaMatrix();
        final Map<String, Country> countryList =
            await countryListRepository.generateCountryListMatrix();

        final VisaMatrix updatedVisaMatrix =
            visaMatrix.enhanceWithCountryList(countryList);

        emit(
          state.copyWith(
            isLoading: false,
            visaMatrix: updatedVisaMatrix,
          ),
        );
      } catch (e, stacktrace) {
        HubLogger.e(
          "Could not generate the visa matrix: $e",
          stackTrace: stacktrace,
        );

        emit(
          state.copyWith(),
        );
      }
    });
  }
}
