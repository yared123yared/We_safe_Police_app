import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wesafepoliceapp/Models/login_info.dart';
import 'package:wesafepoliceapp/Repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit( LoginLoading());
      try {
        
        final _response = await authRepository.login(event.phone, event.password);
        emit(LoginLoadedSuccess(loginInfo: _response));
        
      } catch (e) {
        emit(LoginLoadingError(message: e.toString()));
      }
     
    });
  }
}
