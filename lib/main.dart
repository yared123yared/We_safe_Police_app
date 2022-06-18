import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/case_bloc/case_bloc.dart';
import 'package:wesafepoliceapp/Bloc/criminal_bloc/criminal_bloc.dart';
import 'package:wesafepoliceapp/Bloc/fileupload_bloc/fileupload_bloc.dart';
import 'package:wesafepoliceapp/Bloc/investigation_bloc/investigation_bloc.dart';
import 'package:wesafepoliceapp/Bloc/login_bloc/login_bloc.dart';
import 'package:wesafepoliceapp/Bloc/news_bloc/news_bloc.dart';
import 'package:wesafepoliceapp/Bloc/police_bloc/police_bloc.dart';
import 'package:wesafepoliceapp/Bloc/send_otp_bloc/send_otp_bloc_bloc.dart';
import 'package:wesafepoliceapp/Config/routes.dart';
import 'package:wesafepoliceapp/Dataprovider/dataprovider.dart';
import 'package:wesafepoliceapp/Dataprovider/news_data_provider.dart';
import 'package:wesafepoliceapp/Repository/auth_repository.dart';
import 'package:wesafepoliceapp/Repository/case_respository.dart';
import 'package:wesafepoliceapp/Repository/news_repository.dart';
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

  NewsRespository _newsRespository = NewsRespository(
      dataProvider: NewsDataProvider(httpClient: http.Client()));
  final _repository = CaseRepository(
    dataProvider: CaseDataProvider(
      httpClient: http.Client(),
    ),
  );
  runApp(PoliceApp(
    authRepository: _authrepository,
    phoneAuthRepository: phoneAuthRepository,
    newsRespository: _newsRespository,
    caseRepository: _repository,
  ));
}

class PoliceApp extends StatelessWidget {
  const PoliceApp(
      {required this.authRepository,
      required this.phoneAuthRepository,
      required this.newsRespository,
      required this.caseRepository,
      Key? key})
      : super(key: key);
  final AuthRepository authRepository;
  final PhoneAuthRepository phoneAuthRepository;
  final NewsRespository newsRespository;
  final CaseRepository caseRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: authRepository),
        ),
        BlocProvider<SendOtpBlocBloc>(
          create: (context) =>
              SendOtpBlocBloc(phoneAuthRepository: phoneAuthRepository),
        ),
        BlocProvider<NewsBloc>(
          create: (context) =>
              NewsBloc(respository: newsRespository)..add(FetchNews()),
        ),
        BlocProvider<FileuploadBloc>(
          create: (context) => FileuploadBloc(),
        ),
        BlocProvider<CaseBloc>(
          lazy: false,
          create: (context) => CaseBloc(
            repository: caseRepository,
          ),
        ),
        BlocProvider<InvestigationBloc>(
            create: ((context) => InvestigationBloc())),
        BlocProvider(
          create: ((context) => CriminalBloc()
            ..add(
              FetchCriminals(),
            )),
        ),
        BlocProvider<PoliceBloc>(
          create: ((context) => PoliceBloc()),
        ),
      ],
      
      child: MaterialApp(
        initialRoute: PoliceSplashScreen.routeName,
        onGenerateRoute: AppRoute.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: createMaterialColor(Colors.blue),
            primaryColor: kPrimaryColor),
        home: const PoliceHomepage(),
      ),
    );
  }
}
