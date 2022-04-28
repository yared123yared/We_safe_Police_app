import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Screens/login/login_screen.dart';
import 'package:wesafepoliceapp/Screens/otp/otp_screen.dart';
import 'package:wesafepoliceapp/Screens/resetpassword/reset_passowrd.dart';
import 'package:wesafepoliceapp/Screens/screens.dart';
import 'package:wesafepoliceapp/Screens/splash_screen.dart';

class AppRoute{
  static Route generateRoute(RouteSettings settings){
  
     if(settings.name == PoliceSplashScreen.routeName){
        return MaterialPageRoute(builder: (context) => const  PoliceSplashScreen());
    }
      else if(settings.name == PoliceHomepage.routeName){
      return MaterialPageRoute(builder: (context) => const  PoliceHomepage());
    }
    else if(settings.name == PhoneVerification.routeName){
      String _phoneNumber = settings.arguments as String;
      return MaterialPageRoute(builder: (context) =>  PhoneVerification( _phoneNumber ));
    }
    else if(settings.name == ResetPassword.routeName){
      return MaterialPageRoute(builder: (context) => const ResetPassword());
    }
    else if(settings.name == ALertDetail.routeName){
      return MaterialPageRoute(builder: ((context) => const ALertDetail()));
    }
    else if(settings.name == CaseDetail.routeName){
      return MaterialPageRoute(builder: ((context) => const CaseDetail()));
    }
    return MaterialPageRoute(
      builder: (context) => const PoliceLoginpage()
      );
  }
}