import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String iso3code;

  final String? flagUrl;

  const Country({required this.name, required this.iso3code, this.flagUrl});

  @override
  List<Object?> get props => [name, iso3code];
}
