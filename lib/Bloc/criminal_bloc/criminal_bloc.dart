import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wesafepoliceapp/Models/criminal_model.dart';
import 'package:wesafepoliceapp/Repository/criminal_repository.dart';

part 'criminal_event.dart';
part 'criminal_state.dart';

class CriminalBloc extends Bloc<CriminalEvent, CriminalState> {
  final CriminalRepository _criminalRepository = CriminalRepository();
  CriminalBloc() : super(CriminalInitial()) {
    on<FetchCriminals>(_mapFetchCriminaEvent);
  }

  void _mapFetchCriminaEvent(FetchCriminals event, Emitter<CriminalState> emit) async{
    emit(CriminalLoading());
    try {
      final _response = await _criminalRepository.getAllCriminals();
      emit(CriminalLoaded(_response));
      
    } catch (e) {
      emit(CriminalError(e.toString()));
    }
  }

  
}
