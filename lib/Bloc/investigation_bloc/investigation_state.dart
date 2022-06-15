part of 'investigation_bloc.dart';

abstract class InvestigationState extends Equatable {
  const InvestigationState();
  
  @override
  List<Object> get props => [];
}

class InvestigationInitial extends InvestigationState {}

class InvestigationLoading extends InvestigationState{

}

class InvestigationLoaded extends InvestigationState{
  final List<String> images;
  const InvestigationLoaded(this.images);
}

class InvestigationError extends InvestigationState{
  final String errorMessage;
  const InvestigationError(this.errorMessage);
}