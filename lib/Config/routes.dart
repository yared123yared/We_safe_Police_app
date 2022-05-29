import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Models/case.dart';
import 'package:wesafepoliceapp/Models/new_model.dart';
import 'package:wesafepoliceapp/Screens/case_detail/case_evidence_add.dart';
import 'package:wesafepoliceapp/Screens/live_detail/map_detail.dart';
import 'package:wesafepoliceapp/Screens/login/login_screen.dart';
import 'package:wesafepoliceapp/Screens/news_widget.dart/news_detail.dart';
import 'package:wesafepoliceapp/Screens/otp/otp_screen.dart';
import 'package:wesafepoliceapp/Screens/resetpassword/reset_passowrd.dart';
import 'package:wesafepoliceapp/Screens/screens.dart';
import 'package:wesafepoliceapp/Screens/splash_screen.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == PoliceSplashScreen.routeName) {
      return MaterialPageRoute(
          builder: (context) => const PoliceSplashScreen());
    } else if (settings.name == PoliceHomepage.routeName) {
      return MaterialPageRoute(builder: (context) => const PoliceHomepage());
    } else if (settings.name == PhoneVerification.routeName) {
      String _phoneNumber = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => PhoneVerification(_phoneNumber));
    } else if (settings.name == ResetPassword.routeName) {
      return MaterialPageRoute(builder: (context) => const ResetPassword());
    } else if (settings.name == ALertDetail.routeName) {
      return MaterialPageRoute(builder: ((context) => const ALertDetail()));
    } else if (settings.name == LiveDetail.routeName) {
      return MaterialPageRoute(builder: (context) => const LiveDetail());
    } else if (settings.name == MapDetail.routeName) {
      return MaterialPageRoute(builder: (context) => const MapDetail());
    } else if (settings.name == CaseDetail.routeName) {
      final _policeCase = settings.arguments as Case;
      return MaterialPageRoute(
        builder: (context) => CaseDetail(
          policeCase: _policeCase,
        ),
      );
    } else if (settings.name == NewsDetail.routeName) {
      final _news = settings.arguments as NewsModel;
      return MaterialPageRoute(
        builder: (context) => NewsDetail(_news),
      );
    } else if (settings.name == CaseEvidenceAdd.routeName) {
      final _case = settings.arguments as Case;
      return MaterialPageRoute(
        builder: ((context) => CaseEvidenceAdd(
              caseModel: _case,
            )),
      );
    }
    return MaterialPageRoute(builder: (context) => const PoliceLoginpage());
  }
}
