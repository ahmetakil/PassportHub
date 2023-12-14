part of 'visa_bloc.dart';

class VisaState extends Equatable {
  final bool isLoading;
  final Map<Country, List<VisaInformation>>? visaMatrix;

  bool get hasData => visaMatrix != null;

  const VisaState({
    this.isLoading = false,
    this.visaMatrix,
  });

  @override
  List<Object?> get props => [isLoading, visaMatrix];

  VisaState copyWith(
      {bool? isLoading, Map<Country, List<VisaInformation>>? visaMatrix}) {
    return VisaState(
      isLoading: isLoading ?? this.isLoading,
      visaMatrix: visaMatrix ?? this.visaMatrix,
    );
  }
}
