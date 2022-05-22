part of 'case_bloc.dart';

abstract class CaseEvent extends Equatable {
  const CaseEvent();

  @override
  List<Object> get props => [];
}

class FetchCaseByPoliceId extends CaseEvent{
  final bool isFromDelete;
  const FetchCaseByPoliceId(this.isFromDelete);
  
}

class DeleteCase extends CaseEvent{
  final String caseId;

  const DeleteCase(
    this.caseId);
}