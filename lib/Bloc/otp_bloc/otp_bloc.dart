import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Screens/home/homepage.dart';
import 'package:wesafepoliceapp/Screens/otp/otp_screen.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  OtpBloc() : super(OtpInitial()) {
    on<VerifyPhone>((event, emit) async {
     await _verifyPhone(event, emit, event.context);
    });
    on<SigninWithCredential>(((event, emit) async{
      await _signinWithCredential(event, emit);
    }));
  }

 Future _signinWithCredential(SigninWithCredential event,Emitter<OtpState> emit ,) async{
    emit(OptLoading());
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: event.verificationId, smsCode: event.codeText);
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      emit(const OtpVerified('Phone is verified'));
    } catch (e) {
      if (e.toString().toLowerCase().contains("auth credential is invalid")) {
      } else {
        emit(
          OtpError(e.toString())
        );
      }
    }
  }

  Future _verifyPhone(
      VerifyPhone event, Emitter<OtpState> emit, BuildContext context) async {
    // debugPrint('The phone number is ${event.phoneNumber}');

    emit(OptLoading());
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+251" + event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          debugPrint("verification completed${authCredential.smsCode}");
          User? user = FirebaseAuth.instance.currentUser;
          if (authCredential.smsCode != null) {
            try {
              await user!.linkWithCredential(authCredential).whenComplete(() => null);
            
            } on FirebaseAuthException catch (e) {
              if (e.code == 'provider-already-linked') {
                try {
                  await _firebaseAuth.signInWithCredential(authCredential);
                  
                } catch (e) {
                  if (e
                      .toString()
                      .toLowerCase()
                      .contains("auth credential is invalid")) {
                  } else {
                    emit(
                      OtpError(
                        e.toString(),
                      ),
                    );
                  }
                }
              }
            }
          }
        },
        verificationFailed: (exception) {
          debugPrint("The verification error is ${exception.code}");
          if (exception.code == 'invalid-phone-number') {
            debugPrint("The phone Number is invalid");
          }
          String message = getMessageFromErrorCode(exception.code);
          emit(OtpError(message));
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>The verification id is $verificationId");
           emit(const OtpVerified(''));
          await Future.delayed(const Duration(seconds: 1),(() {
             
          })).whenComplete(() =>  Navigator.of(context).pushReplacementNamed(
              PhoneVerification.routeName,
              arguments: event.phoneNumber));
         
          
        },
        codeAutoRetrievalTimeout: (timeout) async {
          // emit(const OtpError("Timeout"));
        },
      );
    } on FirebaseAuthException catch (e) {
      String message = getMessageFromErrorCode(e.code);
      emit(OtpError(message));
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }

  signout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint("somting happened");
    }
  }

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "wrong-password":
        return "Wrong email/password combination.";
      case "user-not-found":
        return "No user found with this email.";
      case "user-disabled":
        return "User disabled.";
      case "too-many-requests":
        return "Too many requests to log into this account.";
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Login failed. Please try again.";
    }
  }
}
