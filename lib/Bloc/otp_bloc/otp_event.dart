part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}


class VerifyPhone extends OtpEvent{
  final String phoneNumber;
 final  BuildContext context;

  const VerifyPhone(
   {
     required this.context,
     required this.phoneNumber
   }
  );
}


class SigninWithCredential extends OtpEvent{
  final String verificationId;
  final String codeText;
  SigninWithCredential({
    required this.codeText,
    required this.verificationId,
  });

}