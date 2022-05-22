import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/login_bloc/login_bloc.dart';
import 'package:wesafepoliceapp/Bloc/send_otp_bloc/send_otp_bloc_bloc.dart';
import 'package:wesafepoliceapp/Config/routes.dart';
import 'package:wesafepoliceapp/Dataprovider/dataprovider.dart';
import 'package:wesafepoliceapp/Repository/auth_repository.dart';
import 'package:wesafepoliceapp/Repository/phone_auth_repository.dart';
import 'package:wesafepoliceapp/Screens/home/homepage.dart';
import 'package:wesafepoliceapp/Screens/splash_screen.dart';
import 'Utils/utils.dart';
import 'package:http/http.dart' as http;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthRepository _authrepository = AuthRepository(
      authDataProvider: AuthDataProvider(httpClient: http.Client()));
  PhoneAuthRepository phoneAuthRepository = PhoneAuthRepository();
  runApp(PoliceApp(
    authRepository: _authrepository,
    phoneAuthRepository: phoneAuthRepository,
  ));
}

class PoliceApp extends StatelessWidget {
  const PoliceApp(
      {required this.authRepository,
      required this.phoneAuthRepository,
      Key? key})
      : super(key: key);
  final AuthRepository authRepository;
  final PhoneAuthRepository phoneAuthRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(authRepository: authRepository)),
        BlocProvider<SendOtpBlocBloc>(
            create: (context) =>
                SendOtpBlocBloc(phoneAuthRepository: phoneAuthRepository))
      ],
      child: MaterialApp(
        initialRoute: PoliceSplashScreen.routeName,
        onGenerateRoute: AppRoute.generateRoute,
        theme: ThemeData(
            primarySwatch: createMaterialColor(Colors.blue),
            primaryColor: kPrimaryColor),
        home: const PoliceHomepage(),
      ),
    );
  }
}
