import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Config/user_preference.dart';
import 'package:wesafepoliceapp/Screens/home/components/home_case.dart';
import 'package:wesafepoliceapp/Screens/home/components/home_live_page.dart';
import 'package:wesafepoliceapp/Screens/home/components/home_alert_page.dart';
import 'package:wesafepoliceapp/Screens/home/components/investigate.dart';
import 'package:wesafepoliceapp/Screens/home/components/news_body.dart';
import 'package:wesafepoliceapp/Screens/login/login_screen.dart';
import 'package:wesafepoliceapp/Screens/resetpassword/reset_passowrd.dart';
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
    // UserPreference _userPreferences = UserPreference();
    // LoginInfo _loginInfo = await _userPreferences.getLoginInformation();
    // debugPrint('User token is ${_loginInfo.token}');
    // debugPrint('User name is ${_loginInfo.person!.firstName}');
    // debugPrint('User add is ${_loginInfo.person!.lastName}');
    // debugPrint('User Picture is ${_loginInfo.person!.picture}');
  }

  int _currentIndex = 0;

  Widget _buildHomeBody(int index) {
    switch (index) {
      case 0:
        return const HomeNews();
      case 1:
        return const HomeLive();
      case 2:
        return const HomeReport();
      case 3:
        return const HomeCase();
      case 4:
        return const InvetagatePage();
      default:
        return const HomeNews();
    }
  }

  _buildAppBarTitle(index) {
    switch (index) {
      case 0:
        return Row(children: [
          GestureDetector(
            onTap: () {
              debugPrint('Reset password page');
                Navigator.of(context).pushNamed(
                  ResetPassword.routeName
                );
            },
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
        ]);
      case 1:
        return const Text(
          "Live",
          style: TextStyle(color: kIconColor),
        );
      case 2:
        return const Text('Alert', style: TextStyle(color: kIconColor));
      case 3:
        return const Text('Cases', style: TextStyle(color: kIconColor));
      case 4:
        return const Text('Investigate', style: TextStyle(color: kIconColor));
      default:
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                
              },
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
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        
        backgroundColor:
            _currentIndex == 2 ? Colors.white : const Color(0xffede8e8),
        appBar: AppBar(
          elevation: _currentIndex == 2 ? 4 : 0.0,
          backgroundColor: Colors.white,
          title: _buildAppBarTitle(_currentIndex),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
                onPressed: () async {
                  UserPreference userPreference = UserPreference();
                  await userPreference.removeLoginInfo();
                  Navigator.pushNamedAndRemoveUntil(
                      context, PoliceLoginpage.routeName, (route) => false);
                }),
            IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: kIconColor,
                  size: 30,
                ))
          ],
          bottom: _currentIndex == 0
              ? const TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'All',
                        style: TextStyle(color: kIconColor),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'New',
                        style: TextStyle(color: kIconColor),
                      ),
                    ),
                    Tab(
                      child:
                          Text('Feature', style: TextStyle(color: kIconColor)),
                    ),
                    Tab(
                      child:
                          Text('Example', style: TextStyle(color: kIconColor)),
                    ),
                  ],
                )
              : null,
        ),
        body: _buildHomeBody(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
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
          unselectedItemColor: kIconColor,
          items: const [
            BottomNavigationBarItem(label: "News", icon: Icon(Icons.newspaper)),
            BottomNavigationBarItem(label: "Live", icon: Icon(Icons.live_tv)),
            BottomNavigationBarItem(
                label: "Alert", icon: Icon(Icons.flag_rounded)),
            BottomNavigationBarItem(label: "Case", icon: Icon(Icons.history)),
            BottomNavigationBarItem(
                label: "Investigate", icon: Icon(Icons.find_replace)),
          ],
        ),
      ),
    );
  }
}
