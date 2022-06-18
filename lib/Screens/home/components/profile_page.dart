import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Models/login_info.dart';
import 'package:wesafepoliceapp/Screens/resetpassword/reset_passowrd.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'wesafepoliceapp/profilePage';
  const ProfilePage({required this.loginInfo, Key? key}) : super(key: key);
  final LoginInfo loginInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    color: const Color(0xFF778899),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          loginInfo.police!.person!.picture.toString(),
                        ))),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "${loginInfo.police!.person!.firstName} ${loginInfo.police!.person!.lastName}"
                    .toUpperCase(),
                style: const TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                loginInfo.police!.person!.role!.roleName.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(loginInfo.police!.person!.phone.toString()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.import_contacts),
                    title: Text(
                        '${loginInfo.police!.person!.address!.city.toString()}, ${loginInfo.police!.person!.address!.subcity.toString()}, ${loginInfo.police!.person!.address!.kebele}'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pushNamed(
                  ResetPassword.routeName
                );
              }, child: const Text('Update Password'))
            ],
          ),
        ),
      ),
    );
  }
}
