import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                            onSaved: (newValue) {
                              
                            },
                            validator: (value){

                            },
                            decoration: const InputDecoration(
                                label: Text('Current Password'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                           onSaved: (newValue) {
                              
                            },
                            validator: (value){
                              
                            },
                            decoration: const InputDecoration(
                          label: Text('Current Password'),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                           onSaved: (newValue) {
                              
                            },
                            validator: (value){
                              
                            },
                          decoration: const InputDecoration(
                            label: Text('New Password'),
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
