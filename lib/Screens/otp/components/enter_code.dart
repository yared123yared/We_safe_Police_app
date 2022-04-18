import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterCodeField extends StatelessWidget {
  const EnterCodeField(
      {required this.errorController,
      required this.formKey,
      required this.onChanged,
      required this.otpController,
      Key? key})
      : super(key: key);

  final TextEditingController otpController;
  final StreamController<ErrorAnimationType>? errorController;
  final GlobalKey<FormState> formKey;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: PinCodeTextField(
          appContext: context,
          pastedTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 3) {
              return "enter six digit";
            } else {
              return null;
            }
          },
          
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveColor: Colors.grey,
            inactiveFillColor: Colors.white,
            selectedColor: Colors.white,
            selectedFillColor: Colors.white,
            activeColor: Colors.grey,
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: errorController,
          backgroundColor: Colors.transparent,
          controller: otpController,
          keyboardType: TextInputType.number,
          boxShadows: const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (v) {
            debugPrint("Completed");
          },
          onChanged: onChanged,
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            return false;
          },
        ),
      ),
    );
  }
}
