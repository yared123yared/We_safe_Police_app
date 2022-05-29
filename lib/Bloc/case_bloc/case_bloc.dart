import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wesafepoliceapp/Models/models.dart';
import 'package:wesafepoliceapp/Repository/repository.dart';

part 'case_event.dart';
part 'case_state.dart';

class CaseBloc extends Bloc<CaseEvent, CaseState> {
  final CaseRepository repository;
  CaseBloc({
    required this.repository,
  }) : super(CaseInitial()) {
    on<FetchCaseByPoliceId>(_mapFetchPoliceCases);
    on<DeleteCase>(_mapDeleteCase);
    on<UpdateCase>(_mapUpdateCase);
  }

  // get case by id
  void _mapFetchPoliceCases(FetchCaseByPoliceId event, Emitter<CaseState> emit) async{
   if(!event.isFromDelete){
      emit(CaseLoading());
   }
    try {
      final _response  = await repository.getAssignedPoliceCases();
      emit(CaseLoaded(_response));
      
    } catch (e) {
      print('The Fetch error is ${e.toString()}');
      emit(CaseError(e.toString()));
    }
    
  }

  // update
  void _mapUpdateCase(UpdateCase event, Emitter<CaseState> emit) async{
    emit (CaseLoading());

    try {
      final _response = await repository.updateCase(
        event.caseModel,
        discription: event.description,
        imagePath: event.imagePath,
        videoPath: event.videoPath,
        voicePath: event.voicePath
        );
      emit(CaseLoaded([_response]));
      
    } catch (e) {
      print('The error is ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  //delete
  void _mapDeleteCase(DeleteCase event, Emitter<CaseState> emit) async{
    // emit(CaseLoading());
    try {
      final _response = await repository.deleteCase(event.caseId);
      emit(CaseDeleteSuccess(_response));
      
    } catch (e) {
      emit(CaseError(e.toString()));


    }
  }
}
