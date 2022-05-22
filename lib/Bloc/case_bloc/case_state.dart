part of 'case_bloc.dart';

abstract class CaseState extends Equatable {
  const CaseState();
  
  @override
  List<Object> get props => [];
}

class CaseInitial extends CaseState {}

class CaseLoading extends CaseState{

}

class CaseLoaded extends CaseState{
  final List<Case> policeCases;
  const CaseLoaded(this.policeCases);
}

class CaseDeleteSuccess extends CaseState{
  final Case policeCase;
  const CaseDeleteSuccess(this.policeCase);
}


class CaseError extends CaseState{
  final String errorMessage;
  const CaseError(this.errorMessage);
}
