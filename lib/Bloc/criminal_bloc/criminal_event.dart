part of 'criminal_bloc.dart';

abstract class CriminalEvent extends Equatable {
  const CriminalEvent();

  @override
  List<Object> get props => [];
}


class FetchCriminals extends CriminalEvent{
  
}