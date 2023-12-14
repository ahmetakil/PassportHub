import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/models/visa_information.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';

part 'visa_event.dart';

part 'visa_state.dart';

class VisaBloc extends Bloc<VisaEvent, VisaState> {
  final VisaRepository repository;

  VisaBloc(this.repository) : super(const VisaState()) {
    on<VisaEvent>((event, emit) async {
      emit(
        state.copyWith(isLoading: true),
      );

      try {
        final Map<Country, List<VisaInformation>> visaMatrix =
            await repository.generateVisaMatrix();
      } catch (e) {}
    });
  }
}
