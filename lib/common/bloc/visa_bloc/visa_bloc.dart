import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';

part 'visa_event.dart';

part 'visa_state.dart';

class VisaBloc extends Bloc<VisaEvent, VisaState> {
  final VisaRepository repository;

  VisaBloc(this.repository) : super(const VisaState()) {
    on<FetchMatrixEvent>((event, emit) async {
      emit(
        state.copyWith(isLoading: true),
      );

      try {
        HubLogger.log("Generating visa matrix");
        final VisaMatrix visaMatrix = await repository.generateVisaMatrix();

        emit(
          state.copyWith(
            isLoading: false,
            visaMatrix: visaMatrix,
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
