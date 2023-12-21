import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String iso3code;
  final String? iso2code;
  final String? name;

  final String? region;
  final String? subRegion;

  const Country({
    required this.iso3code,
    this.iso2code,
    this.name,
    this.region,
    this.subRegion,
  });

  @override
  String toString() {
    return "Country<$iso3code | $name>";
  }

  @override
  List<Object?> get props => [iso3code];
}
