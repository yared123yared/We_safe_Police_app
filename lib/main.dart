import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/login_bloc/login_bloc.dart';
import 'package:wesafepoliceapp/Config/routes.dart';
import 'package:wesafepoliceapp/Dataprovider/dataprovider.dart';
import 'package:wesafepoliceapp/Repository/auth_repository.dart';
import 'package:wesafepoliceapp/Screens/login/login_screen.dart';
import 'package:wesafepoliceapp/Screens/otp/otp_screen.dart';
import 'package:wesafepoliceapp/Screens/resetpassword/reset_passowrd.dart';
import 'package:wesafepoliceapp/Screens/splash_screen.dart';
import 'Utils/utils.dart';
import 'package:http/http.dart' as http;

void main() {
  AuthRepository _authrepository = AuthRepository(authDataProvider: AuthDataProvider(httpClient: http.Client()));
  runApp( PoliceApp(
    authRepository: _authrepository,
  ));
}


class PoliceApp extends StatelessWidget {
  const PoliceApp({required this.authRepository, Key? key }) : super(key: key);
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(authRepository: authRepository))
      ],
      child: MaterialApp(
        initialRoute: ResetPassword.routeName,
        onGenerateRoute: AppRoute.generateRoute,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white
        ),
        home: const PhoneVerification(
          {}
        ),
      ),
    );
  }
}