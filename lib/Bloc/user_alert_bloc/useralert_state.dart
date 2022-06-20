part of 'useralert_bloc.dart';

abstract class UseralertState extends Equatable {
  const UseralertState();
  
  @override
  List<Object> get props => [];
}

class UseralertInitial extends UseralertState {}

class UserAlertLoading extends UseralertState{}


class UserAlertLoaded extends UseralertState{
  final List<UserAlert> userAlerts;
  const UserAlertLoaded({required this.userAlerts});
}


class UserAlertError extends UseralertState{
  final String message;
  const UserAlertError({required this.message});
}
