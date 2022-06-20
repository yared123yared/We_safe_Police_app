import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wesafepoliceapp/Bloc/send_otp_bloc/send_otp_bloc_bloc.dart';
import 'package:wesafepoliceapp/Screens/home/homepage.dart';
import 'package:wesafepoliceapp/Screens/otp/components/enter_code.dart';
import 'package:wesafepoliceapp/Widgets/custom_button.dart';

class PhoneVerification extends StatefulWidget {
  static const routeName = 'wesavepoliceapp/phoneVerification';
  final String phoneNumber;
  const PhoneVerification(this.phoneNumber, {Key? key}) : super(key: key);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  String _verificationId = '';
  TextEditingController otpController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  _pleaseFillAllCell() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        hasError ? "*Please fill up all the cells properly" : "",
        style: const TextStyle(
            color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: BlocListener<SendOtpBlocBloc, SendOtpBlocState>(
          listener: (context, state) {
        if (state is PhoneAuthVerified) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                content: Container(
                  height: 50,
                  width: 200,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 39.0,
                      ),
                      SizedBox(width: 20.0),
                      Center(
                        child: Text(
                          "Verified",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            await Future.delayed(
              const Duration(seconds: 2),
            ).whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
                  PoliceHomepage.routeName,
                  (route) => false,
                ));
          });
        } else if (state is PhoneAuthError) {
          Navigator.of(context).pop();
          debugPrint("error occured");
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Container(
                height: 50,
                width: 200,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is PhoneAuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              content: Row(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text('verifying')
                ],
              ),
            ),
          );
        }
      }, child: BlocBuilder<SendOtpBlocBloc, SendOtpBlocState>(
              builder: (context, state) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: ListView(
            children: <Widget>[
              _buildImage(
                size.height * 0.4,
              ),
              _buildVerifyYourAccount(),
              _buildEnterCodeText('+251929465849'),
              const SizedBox(
                height: 20,
              ),
              EnterCodeField(
                errorController: errorController,
                formKey: formKey,
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    currentText = value;
                  });
                },
                otpController: otpController,
              ),
              const SizedBox(
                height: 20,
              ),
              _pleaseFillAllCell(),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: CustomeButton(
                    child: const Text(
                      "VERIFY",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      debugPrint('Start verifying');
                      debugPrint('Start verifying ${currentText.length != 6}');
                      formKey.currentState!.validate();
                      // conditions for validating
                      if (currentText.length != 6) {
                        errorController!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() => hasError = true);
                      } else {
                        if (state is PhoneAuthCodeSentSuccess) {
                          setState(() {
                            _verificationId = state.verificationId;
                          });
                          context.read<SendOtpBlocBloc>().add(
                                VerifySentOtpEvent(
                                  otpCode: currentText,
                                  verificationId: state.verificationId,
                                ),
                              );
                        } else if (state is PhoneAuthError) {
                          if (_verificationId.isNotEmpty) {
                            context.read<SendOtpBlocBloc>().add(
                                  VerifySentOtpEvent(
                                    otpCode: currentText,
                                    verificationId: _verificationId,
                                  ),
                                );
                          }
                        }
                      }
                    }),
              ),
            ],
          ),
        );
      })),
    );
  }

  Widget _buildVerifyYourAccount() {
    return const Center(
      child: SizedBox(
        height: 50,
        child: Text(
          'Verify Your Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
    );
  }

  Widget _buildImage(double height) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset('assets/images/loudspeaker-1459128_1280 1.png'),
      ),
    );
  }

  Widget _buildEnterCodeText(String phoneNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
      child: RichText(
        text: TextSpan(
            text: "Enter the code sent to ",
            children: [
              TextSpan(
                  text: phoneNumber,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ],
            style: const TextStyle(color: Colors.black54, fontSize: 15)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
