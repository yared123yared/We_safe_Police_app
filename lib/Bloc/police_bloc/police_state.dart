part of 'police_bloc.dart';

abstract class PoliceState extends Equatable {
  const PoliceState();
  
  @override
  List<Object> get props => [];
}

class PoliceInitial extends PoliceState {}

class PoliceLoading extends PoliceState{}

class PoliceLoaded extends PoliceState{
  final Police police;
  const PoliceLoaded(this.police);
}

class PoliceError extends PoliceState{
  final String message;
  const PoliceError(this.message);
  
}
