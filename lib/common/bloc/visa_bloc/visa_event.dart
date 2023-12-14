part of 'visa_bloc.dart';

abstract class VisaEvent {
  const VisaEvent();
}

class FetchMatrixEvent extends VisaEvent {
  const FetchMatrixEvent();
}
