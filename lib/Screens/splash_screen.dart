import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Config/user_preference.dart';
import 'package:wesafepoliceapp/Screens/home/homepage.dart';
import 'package:wesafepoliceapp/Screens/login/login_screen.dart';



class PoliceSplashScreen extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/splashscreen';
  const PoliceSplashScreen({ Key? key }) : super(key: key);

  @override
  State<PoliceSplashScreen> createState() => _PoliceSplashScreenState();
}

class _PoliceSplashScreenState extends State<PoliceSplashScreen> {
  
  @override
  void initState() {
    super.initState();
    _getUser();   
  }

  Future _getUser() async{
     UserPreference _userpreference = UserPreference();
     bool _loginInfo = await  _userpreference.isLoggedIn();
     if(!_loginInfo ){
       Navigator.pushReplacementNamed(context, PoliceLoginpage.routeName);
     }else{
       Navigator.of(context).pushReplacementNamed(PoliceHomepage.routeName);
     }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,

        ),
      
    );
  }
}