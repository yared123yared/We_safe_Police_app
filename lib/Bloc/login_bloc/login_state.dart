part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {

}

class LoginLoading extends LoginState{

}

class LoginLoadedSuccess extends LoginState{
  final LoginInfo loginInfo;
  const LoginLoadedSuccess({
    required this.loginInfo,
  });
}

class LoginLoadingError extends LoginState{
  final String message;
  const LoginLoadingError({
    required this.message
  });

}