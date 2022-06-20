import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wesafepoliceapp/Dataprovider/user_alert_data_provider.dart';
import 'package:wesafepoliceapp/Models/alert_model.dart';
import 'package:wesafepoliceapp/Repository/alert_repository.dart';
import 'package:http/http.dart' as http;

part 'useralert_event.dart';
part 'useralert_state.dart';

class UseralertBloc extends Bloc<UseralertEvent, UseralertState> {
  final UserAlertRepository _alertRepository = UserAlertRepository(
    dataProvider: UserAlertDataProvider(
      httpClient: http.Client(),
    ),
  );
  UseralertBloc() : super(UseralertInitial()) {
    on<GetUserALert>(_mapGetUserAlert);
  }

  void _mapGetUserAlert(
      GetUserALert event, Emitter<UseralertState> emit) async {
    emit(UserAlertLoading());
    try {
      final _response = await _alertRepository.getAllAlerts();
      emit(UserAlertLoaded(userAlerts: _response));
    } catch (e) {
      emit(UserAlertError(message: e.toString()));
    }
  }
}
