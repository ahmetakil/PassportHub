part of 'travel_bloc.dart';

abstract class TravelState extends Equatable {
  const TravelState();
}

class TravelInitial extends TravelState {
  @override
  List<Object> get props => [];
}
