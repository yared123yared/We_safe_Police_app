import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wesafepoliceapp/Bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/send_otp_bloc/send_otp_bloc_bloc.dart';

class LoginComponents {
  Widget loginForm(
      GlobalKey<FormState> formKey,
      TextEditingController phoneController,
      TextEditingController passwordController,
      BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: phoneController,
            // onSaved: (value){
            //   setState(() {
            //     _phone = value!;
            //   });
            // },
            onSaved: (value) {
              phoneController.text = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Phone is Required!';
              } else if (value.length < 9) {
                return 'Phone number should greater than 10';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Phone'),
            ),
          ),
          TextFormField(
            // onSaved: (value){
            //   setState(() {
            //     _password = value!;
            //   });
            // },
            onSaved: (value) {
              passwordController.text = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password is Required!';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Password'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              'Forgot password?',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                formKey.currentState!.save();
                if (formKey.currentState!.validate()) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    LoginEvent _loginEvent = LoginSubmitted(
                      password: passwordController.text,
                      phone: phoneController.text,
                    );
                    context.read<LoginBloc>().add(_loginEvent);
                  });


                  
                }
              },
              child: const Text(
                'Sign in',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginHeader() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/loudspeaker.png',
                ),
                fit: BoxFit.fill),
          ),
        ),
        const Positioned(
          bottom: 30,
          left: 120,
          child: Text(
            'We Safe',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Princess_Sofia',
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
