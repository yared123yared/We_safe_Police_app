import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Repository/phone_auth_repository.dart';
import 'package:wesafepoliceapp/Screens/otp/otp_screen.dart';

part 'send_otp_bloc_event.dart';
part 'send_otp_bloc_state.dart';

class SendOtpBlocBloc extends Bloc<SendOtpBlocEvent, SendOtpBlocState> {
  final auth = FirebaseAuth.instance;
  final PhoneAuthRepository phoneAuthRepository;
  SendOtpBlocBloc({
    required this.phoneAuthRepository,
  }) : super(PhoneAuthInitial()) {
   
       on<SendOtpToPhoneEvent>(_onSendOtp);

      on<VerifySentOtpEvent>(_onVerifyOtp);

     on<OnPhoneOtpSent>((event, emit) =>
         emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId)));

     on<OnPhoneAuthErrorEvent>(
         (event, emit) => emit(PhoneAuthError(error: event.error)));

     on<OnPhoneAuthVerificationCompleteEvent>(_loginWithCredential);


  }
  Future<void> _onSendOtp(
    SendOtpToPhoneEvent event, Emitter<SendOtpBlocState> emit) async {
      debugPrint('verifying the phone number');
      String phoneNumber = event.phoneNumber.substring(
        1, 10
      );
      debugPrint("the phone number is ${phoneNumber}");
  emit(PhoneAuthLoading());
  try {
    await phoneAuthRepository.verifyPhone(
      phoneNumber:"+251"+ phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
      },
      codeSent: (String verificationId, int? resendToken) {
        add(OnPhoneOtpSent(
            verificationId: verificationId, token: resendToken));
        Navigator.of(event.context).pushReplacementNamed(PhoneVerification.routeName);
      },
      verificationFailed: (FirebaseAuthException e) {
        add(OnPhoneAuthErrorEvent(error: e.code));
        
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  } catch (e) {
    emit(PhoneAuthError(error: e.toString()));
  }
}

Future<void> _onVerifyOtp(
    VerifySentOtpEvent event, Emitter<SendOtpBlocState> emit) async {
  try {
    emit(PhoneAuthLoading());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: event.verificationId,
      smsCode: event.otpCode,
    );
    add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
  } catch (e) {
    emit(PhoneAuthError(error: e.toString()));
  }
}
Future<void> _loginWithCredential(
    OnPhoneAuthVerificationCompleteEvent event,
    Emitter<SendOtpBlocState> emit) async {
  try {
    await auth.signInWithCredential(event.credential).then((user) {
      if (user.user != null) {
        emit(PhoneAuthVerified());
      }
    });
  } on FirebaseAuthException catch (e) {
    emit(PhoneAuthError(error: e.code));
  } catch (e) {
    emit(PhoneAuthError(error: e.toString()));
  }
}



}
