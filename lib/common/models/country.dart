import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String iso3code;
  final String? name;

  final String? flagUrl;
  final String? region;
  final String? subRegion;

  const Country({
    required this.iso3code,
    this.name,
    this.flagUrl,
    this.region,
    this.subRegion,
  });

  @override
  List<Object?> get props => [iso3code];
}
