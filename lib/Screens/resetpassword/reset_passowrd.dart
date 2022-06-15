import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/police_bloc/police_bloc.dart';
import 'package:wesafepoliceapp/Config/user_preference.dart';
import 'package:wesafepoliceapp/Models/login_info.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = "wesafepoliceapp/changepassword";

  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _showCurrentPassword = false;
  bool _showNewPassWord = false;
  bool _showConfirmPassowrd = false;
  late Police _loggedInPolice;
  @override
  void initState() {
    _getLoggedInPolice();
    super.initState();
  }

  _getLoggedInPolice() async {
    final _loggedInpoliceInfo = await UserPreference().getLoginInformation();
    setState(() {
      _loggedInPolice = _loggedInpoliceInfo.police!;
    });
  }

  String _newPassword = '';
  String _confirmPassword = '';
    _showSnackBar(String message, Color color){
    SnackBar _snackBar = SnackBar(
      backgroundColor: Colors.grey,
      content: Text(message, style:  TextStyle(
        color: color
      ),)
      );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar,);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: BlocListener<PoliceBloc, PoliceState>(
        listener: (context, state) {
          if (state is PoliceLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                  content: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: size.width - 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 40.0,
                    ),
                    Text('Loading')
                  ],
                ),
              )),
            );
          }else if(state is PoliceLoaded){
            Navigator.of(context).pop();
            _showSnackBar('Successfully updated!', Colors.green);
          }else if( state is PoliceError){
             Navigator.of(context).pop();
            _showSnackBar(state.message, Colors.red);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  height: 40,
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          obscureText: _showCurrentPassword,
                          onSaved: (newValue) {},
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Current Password Required!';
                            }else if(value != _loggedInPolice.person!.password){
                              return 'Current Password is not Correct';
                            }else{
                                  '';
                            }
                          },
                          decoration: InputDecoration(
                              label: const Text('Current Password'),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showCurrentPassword =
                                          !_showCurrentPassword;
                                    });
                                  },
                                  icon: Icon(_showCurrentPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        child: TextFormField(
                          obscureText: _showNewPassWord,
                          onSaved: (newValue) {
                            setState(() {
                              _newPassword = newValue!;
                            });
                          },
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Field required!";
                            }else if(value.length < 6){
                              return 'Password is too short!';
                            }
                            return null;
                           
                          },
                          decoration: InputDecoration(
                            label: const Text(
                              'New Password',
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showNewPassWord = !_showNewPassWord;
                                });
                              },
                              icon: Icon(
                                _showNewPassWord
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          obscureText: _showConfirmPassowrd,
                          onSaved: (newValue) {
                            setState(() {
                              _confirmPassword = newValue!;
                            });
                          },
                          validator: (value) {
                            if(value != _newPassword){
                              return "Password don't match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Confirm Password'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showConfirmPassowrd =
                                      !_showConfirmPassowrd;
                                });
                              },
                              icon: Icon(
                                _showConfirmPassowrd
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                            color: Colors.blue),
                        child: TextButton(
                          child: const Text(
                            'New Password',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            _formKey.currentState!.save();
                            if(_formKey.currentState!.validate()){
                              debugPrint('Validated');
                              debugPrint(_newPassword);
                              BlocProvider.of<PoliceBloc>(context).add(
                                ResetPasswordEvent(
                                    newPassword: _newPassword

                                )
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
