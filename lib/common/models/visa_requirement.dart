import 'package:equatable/equatable.dart';

enum VisaRequirementType {
  visaFree,
  visaOnArrival,
  eVisa,
  visaRequired,
  noAdmission,
  none;
}

extension VisaRequirementExtension on VisaRequirementType {
  double get score {
    return switch (this) {
      VisaRequirementType.visaFree => 3,
      VisaRequirementType.visaOnArrival => 2,
      VisaRequirementType.eVisa => 1,
      _ => 0,
    };
  }

  String get label {
    return switch (this) {
      VisaRequirementType.visaFree => "Visa Free",
      VisaRequirementType.visaOnArrival => "Visa on Arrival",
      VisaRequirementType.eVisa => "Evisa",
      VisaRequirementType.visaRequired => "Visa Required",
      VisaRequirementType.noAdmission => "No Admission",
      VisaRequirementType.none => "N/A",
    };
  }
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

  factory VisaRequirement.fromValue(dynamic value) {
    if (value == "visa required") {
      return const VisaRequirement(type: VisaRequirementType.visaRequired);
    }

    if (value == "e-visa") {
      return const VisaRequirement(type: VisaRequirementType.eVisa);
    }

    if (value == "no admission") {
      return const VisaRequirement(type: VisaRequirementType.noAdmission);
    }

    if (value == "visa on arrival") {
      return const VisaRequirement(type: VisaRequirementType.visaOnArrival);
    }

    if (value is int) {
      return VisaRequirement(
        type: VisaRequirementType.visaFree,
        daysAllowed: value,
      );
    }

    if (value is String && int.tryParse(value) != null) {
      return VisaRequirement(
        type: VisaRequirementType.visaFree,
        daysAllowed: int.tryParse(value),
      );
    }

    if (value == "visa free") {
      return const VisaRequirement(type: VisaRequirementType.visaFree);
    }

    return const VisaRequirement(type: VisaRequirementType.none);
  }

  @override
  List<Object?> get props => [type, daysAllowed];
}
