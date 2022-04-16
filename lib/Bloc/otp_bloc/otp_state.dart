part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  const OtpState();
  
  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OptLoading extends OtpState{}

class OtpVerified extends OtpState{
 final  String message;
  const OtpVerified(
    this.message
  );
}



class OtpError extends OtpState{
  final String message;
  const OtpError(
    this.message
  );
}