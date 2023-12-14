import 'package:equatable/equatable.dart';

enum VisaRequirementType {
  visaFree,
  visaOnArrival,
  eVisa,
  visaRequired,
  noAdmission,
  none;
}

class VisaRequirement extends Equatable {
  final VisaRequirementType type;
  final int? daysAllowed;

  const VisaRequirement({required this.type, this.daysAllowed});

  const VisaRequirement.unlimited()
      : type = VisaRequirementType.visaFree,
        daysAllowed = -1;

  const VisaRequirement.noEntry()
      : type = VisaRequirementType.visaRequired,
        daysAllowed = 0;

  @override
  List<Object?> get props => [type, daysAllowed];
}
