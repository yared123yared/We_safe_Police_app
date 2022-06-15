import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wesafepoliceapp/Dataprovider/investigate.dart';
import 'package:wesafepoliceapp/Repository/investigate.dart';
import 'package:http/http.dart' as http;

part 'investigation_event.dart';
part 'investigation_state.dart';

class InvestigationBloc extends Bloc<InvestigationEvent, InvestigationState> {
  final InvestigateRepository _repository = InvestigateRepository(dataProvider: InvestigateDataProvider(
    httpClient: http.Client()
  ));
  InvestigationBloc() : super(InvestigationInitial()) {
    on<SearchImageEvent>(_mapSearchImage);
  }

  void _mapSearchImage(SearchImageEvent event, Emitter<InvestigationState> emit)async{
    emit(InvestigationLoading());
    try {
      final _response = await _repository.getSearchedImages(event.image!);
      emit(InvestigationLoaded(_response));
      
    } catch (e) {
      
      emit(InvestigationError(e.toString()));
    }
  }
}
