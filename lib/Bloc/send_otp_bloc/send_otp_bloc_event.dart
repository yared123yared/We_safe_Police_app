part of 'send_otp_bloc_bloc.dart';

abstract class SendOtpBlocEvent extends Equatable {
  const SendOtpBlocEvent();

  @override
  List<Object> get props => [];
}

class SendOtpToPhoneEvent extends SendOtpBlocEvent {
  final String phoneNumber;
  final BuildContext context;

  const SendOtpToPhoneEvent({required this.phoneNumber, required this.context,});

  @override
  List<Object> get props => [phoneNumber];
}


class VerifySentOtpEvent extends SendOtpBlocEvent {
  final String otpCode;
  final String verificationId;

  const VerifySentOtpEvent(
      {required this.otpCode, required this.verificationId});

  @override
  List<Object> get props => [otpCode, verificationId];
}

class OnPhoneOtpSent extends SendOtpBlocEvent {
   final String verificationId;
   final int? token;
   const OnPhoneOtpSent({
     required this.verificationId,
     required this.token,
   });

   @override
   List<Object> get props => [verificationId];
}

class OnPhoneAuthErrorEvent extends SendOtpBlocEvent {
   final String error;
   const OnPhoneAuthErrorEvent({required this.error});

   @override
   List<Object> get props => [error];
}

class OnPhoneAuthVerificationCompleteEvent extends SendOtpBlocEvent {
   final AuthCredential credential;
   const OnPhoneAuthVerificationCompleteEvent({
     required this.credential,
   });
}
