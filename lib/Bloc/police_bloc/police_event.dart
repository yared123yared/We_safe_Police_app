part of 'police_bloc.dart';

abstract class PoliceEvent extends Equatable {
  const PoliceEvent();

  @override
  List<Object> get props => [];
}


class ResetPasswordEvent extends PoliceEvent{
  final String newPassword;
  const ResetPasswordEvent({required this.newPassword});
}