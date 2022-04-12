import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Config/user_preference.dart';
import 'package:wesafepoliceapp/Models/login_info.dart';
import 'package:wesafepoliceapp/Screens/home/components/home_history.dart';
import 'package:wesafepoliceapp/Screens/home/components/home_live_page.dart';
import 'package:wesafepoliceapp/Screens/home/components/home_report_page.dart';
import 'package:wesafepoliceapp/Screens/home/components/news_body.dart';
import 'package:wesafepoliceapp/Screens/login/login_screen.dart';
import 'package:wesafepoliceapp/Utils/utils.dart';

class PoliceHomepage extends StatefulWidget {
  static const routeName = 'wesafepolice/homepage';
  const PoliceHomepage({Key? key}) : super(key: key);

  @override
  State<PoliceHomepage> createState() => _PoliceHomepageState();
}

class _PoliceHomepageState extends State<PoliceHomepage> {
  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    UserPreference _userPreferences = UserPreference();
    LoginInfo _loginInfo = await _userPreferences.getLoginInformation();
    debugPrint('User token is ${_loginInfo.token}');
    debugPrint('User name is ${_loginInfo.person!.firstName}');
    debugPrint('User add is ${_loginInfo.person!.lastName}');
    debugPrint('User Picture is ${_loginInfo.person!.picture}');
  }

 int  _currentIndex = 0;

 Widget _buildHomeBody(int index){
   switch(index){
     case 0:
      return const HomeNews();
     case 1:
     return const HomeLive();
     case 2:
     return const HomeReport();
     case 3:
     return const HomeHistory();
     default:
     return const HomeNews();
   }
 }

  @override
  Widget build(BuildContext context) {
    
    debugPrint("Home page");
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const  Color(0xffede8e8),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Row(children: [
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.notifications,
                color: kIconColor,
                size: 30.0,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: kIconColor,
                size: 30,
              ),
            ),
          ]),
    
          actions: [
           
            IconButton(
              padding: const EdgeInsets.only(right: 10),
              onPressed: (){}, icon: const Icon(
              Icons.menu,
             color: kIconColor,
                size: 30,))
          ],
          bottom: _currentIndex ==0? const TabBar(
            tabs: [
              Tab(
                child: Text('All', style: TextStyle(
                  color: kIconColor
                ),
                ),
              ),
              Tab(
                child: Text('New', style: TextStyle(
                  color:kIconColor
                ),),
              ),
              Tab(
                child: Text('Feature', style: TextStyle(
                  color:kIconColor
                )),
              ),
              Tab(
                child: Text('Example', style: TextStyle(
                  color: kIconColor
                )),
              ),
            ],
          ): null,
          
        ),
        body:_buildHomeBody(_currentIndex),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex ,
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
              
            });
          },
          // fixedColor: Colors.black,
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          unselectedItemColor:kIconColor,
          items: const [
            BottomNavigationBarItem(

              label: "News",
              icon: Icon(Icons.newspaper)
              ),
                BottomNavigationBarItem(
                  label: "Live",
              icon: Icon(Icons.live_tv)
              ),
                BottomNavigationBarItem(
                  label: "Report",
              icon: Icon(Icons.flag_rounded)
              ),
                BottomNavigationBarItem(
                  label: "History",
              icon: Icon(Icons.history)
              ),
              
          ],
        ),
      ),
    );
  }
}
