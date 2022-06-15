part of 'criminal_bloc.dart';

abstract class CriminalState extends Equatable {
  const CriminalState();
  
  @override
  List<Object> get props => [];
}

class CriminalInitial extends CriminalState {}

class CriminalLoading extends CriminalState{

}

class CriminalLoaded extends CriminalState{
  final List<CriminalModel> criminals;
  const CriminalLoaded(this.criminals);
}

class CriminalError extends CriminalState{
  final String errorMessage;
  const CriminalError(this.errorMessage);
}
