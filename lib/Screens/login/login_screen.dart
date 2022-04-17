import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/login_bloc/login_bloc.dart';
import 'package:wesafepoliceapp/Bloc/send_otp_bloc/send_otp_bloc_bloc.dart';
import 'package:wesafepoliceapp/Screens/home/homepage.dart';
import 'package:wesafepoliceapp/Screens/login/components/login_components.dart';

class PoliceLoginpage extends StatefulWidget {
  static const routeName = 'wesafepolice/login';
  const PoliceLoginpage({Key? key}) : super(key: key);

  @override
  State<PoliceLoginpage> createState() => _PoliceLoginpageState();
}

class _PoliceLoginpageState extends State<PoliceLoginpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  _showSnackBar(String message){
    SnackBar _snackBar = SnackBar(
      backgroundColor: Colors.grey,
      content: Text(message, style: const TextStyle(
        color: Colors.red
      ),)
      );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar,);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          builder: (context, state) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              
                
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginComponents().buildLoginHeader(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 80,
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      LoginComponents().loginForm(_formKey, _phoneController, _passwordController, context),
                      
                    ],
                  ),
                )
              ],
            ),
          ),
          listener: (context, state) {
            if (state is LoginLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  content: Row(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(width: 10),
                      Text('Signing in')
                    ],
                  ),
                ),
              );
            }
            else if(state is LoginLoadedSuccess){
              // Navigator.of(context).pop();
              // Navigator.of(context).pushReplacementNamed(PoliceHomepage.routeName
              // );
              _sendOtp(phoneNumber: _phoneController.text, context: context);
            }
            else if (state is LoginLoadingError) {
              Navigator.of(context).pop();
             _showSnackBar(state.message);
            }

          },
        ),
      ),
    );
  }
   void _sendOtp({required String phoneNumber, required BuildContext context}) {
    context.read<SendOtpBlocBloc>().add(
          SendOtpToPhoneEvent(
            phoneNumber: phoneNumber,
            context: context
          ),
        );
  }

}
