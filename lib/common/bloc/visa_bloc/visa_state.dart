part of 'visa_bloc.dart';

class VisaState extends Equatable {
  final bool isLoading;
  final VisaMatrix? visaMatrix;

  final String? error;

  bool get hasData => visaMatrix != null;

  const VisaState({
    this.isLoading = false,
    this.visaMatrix,
  }) : error = null;

  const VisaState.error({
    this.error,
    this.visaMatrix,
  }) : isLoading = false;

  @override
  List<Object?> get props => [isLoading, visaMatrix];

  VisaState copyWith({
    bool? isLoading,
    VisaMatrix? visaMatrix,
  }) {
    return VisaState(
      isLoading: isLoading ?? this.isLoading,
      visaMatrix: visaMatrix ?? this.visaMatrix,
    );
  }
}
