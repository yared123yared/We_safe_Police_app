import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Config/user_preference.dart';
import 'package:wesafepoliceapp/Models/login_info.dart';
import 'package:wesafepoliceapp/Screens/home/components/profile_page.dart';
import 'package:wesafepoliceapp/Screens/login/login_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserPreference _userPreference = UserPreference();
    return Drawer(
      child: Center(
        child: FutureBuilder<LoginInfo>(
            future: _userPreference.getLoginInformation(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasData) {
                LoginInfo _logininfo = asyncSnapshot.data!;
                return Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: Colors.blue),
                      accountName: Text(
                          "${_logininfo.police!.person!.firstName} ${_logininfo.police!.person!.lastName}"),
                      accountEmail: Text('${_logininfo.police!.person!.phone}'),
                      currentAccountPicture: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: const Color(0xFF778899),
                        backgroundImage: NetworkImage(
                            _logininfo.police!.person!.picture.toString()),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Profile"),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ProfilePage.routeName,
                          arguments: _logininfo
                        );
                      },
                    ),
                     ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Logout"),
                      onTap: () async {
                        UserPreference userPreference = UserPreference();
                  await userPreference.removeLoginInfo();
                  Navigator.pushNamedAndRemoveUntil(
                      context, PoliceLoginpage.routeName, (route) => false);
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
