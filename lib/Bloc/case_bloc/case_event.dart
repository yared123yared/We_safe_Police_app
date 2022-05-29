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

class UpdateCase extends CaseEvent{
  final Case caseModel;
  final String? imagePath;
  final String? videoPath;
  final String? voicePath;
  final String? description;
  const UpdateCase({
    required  this.caseModel,
    this.imagePath,
    this.videoPath,
    this.voicePath,
    this.description,
  });
}

class DeleteCase extends CaseEvent{
  final String caseId;

  const DeleteCase(
    this.caseId);
}