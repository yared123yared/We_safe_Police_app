import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wesafepoliceapp/Dataprovider/dataprovider.dart';
import 'package:wesafepoliceapp/Models/login_info.dart';
import 'package:wesafepoliceapp/Repository/auth_repository.dart';
import 'package:http/http.dart' as http;

part 'police_event.dart';
part 'police_state.dart';

class PoliceBloc extends Bloc<PoliceEvent, PoliceState> {
  final AuthRepository _authRepository = AuthRepository(authDataProvider: AuthDataProvider(httpClient: http.Client(),),);
  PoliceBloc() : super(PoliceInitial()) {
    on<ResetPasswordEvent>(_mapResetPasswordEvent);
  }

  void _mapResetPasswordEvent(ResetPasswordEvent event, Emitter<PoliceState> emit) async{
    emit(PoliceLoading());
    try {
      final _response = await _authRepository.resetPolicePassword(event.newPassword);
      emit(PoliceLoaded(_response));
      
    } catch (e) {
      emit(PoliceError(e.toString()));
    }
  }
}
