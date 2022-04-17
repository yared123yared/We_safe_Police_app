part of 'send_otp_bloc_bloc.dart';

abstract class SendOtpBlocState extends Equatable {
  const SendOtpBlocState();
  
  @override
  List<Object> get props => [];
}

class PhoneAuthInitial extends SendOtpBlocState {}


class PhoneAuthLoading extends SendOtpBlocState {}

class PhoneAuthError extends SendOtpBlocState {
   final String error;

   const PhoneAuthError({required this.error});

   @override
   List<Object> get props => [error];
}

class PhoneAuthVerified extends SendOtpBlocState {}

class PhoneAuthCodeSentSuccess extends SendOtpBlocState {
   final String verificationId;
   const PhoneAuthCodeSentSuccess({
     required this.verificationId,
   });
   @override
   List<Object> get props => [verificationId];
}
