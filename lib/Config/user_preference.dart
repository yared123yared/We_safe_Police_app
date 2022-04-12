import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wesafepoliceapp/Models/login_info.dart';
import 'package:wesafepoliceapp/Models/models.dart';

class PreferedData<T>{
  T date;
  bool? status;
  PreferedData({
    required this.date,
    this.status
  });
}


class UserPreference{
//   Future storeLogininformation(LoginInfo loginInfo) async{

//     SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
//     String _address = loginInfo.person!.address != null? jsonEncode(loginInfo.person!.address): '';
//     String _role =  jsonEncode(loginInfo.person!.role);

//     await _sharedPreferences.setInt('personId', loginInfo.person!.personId!);
//     await _sharedPreferences.setString('firstName', loginInfo.person!.firstName!);
//     await _sharedPreferences.setString('lastName', loginInfo.person!.lastName!);
//     await _sharedPreferences.setString('password', loginInfo.person!.password!);
//     await _sharedPreferences.setString('phone', loginInfo.person!.phone!);
//     await _sharedPreferences.setString('password', loginInfo.person!.password!);
//     await _sharedPreferences.setString('sex', loginInfo.person!.sex!);
//     await _sharedPreferences.setString('address', _address);
//     await _sharedPreferences.setInt('roleId', loginInfo.person!.roleId!);
//     await _sharedPreferences.setString('role', _role);
//     await _sharedPreferences.setString('token', loginInfo.token!);
//   }

//  Future<LoginInfo> getUserInformation()async{
//        SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
//       return await LoginInfo(
//         person: Person(
//           personId: _sharedPreferences.getInt('personId'),
//           firstName: _sharedPreferences.getString('firstName'),
//           lastName: _sharedPreferences.getString('lastName'),
//           password: _sharedPreferences.getString('password'),
//           sex: _sharedPreferences.getString('sex'),
//           picture: _sharedPreferences.getString('String'),
//           role: Role.fromJson(jsonDecode(_sharedPreferences.getString('role')!)),
//           address: _sharedPreferences.getString('address')  == ''? Address():Address.fromJson(jsonDecode(_sharedPreferences.getString('')!))

//         ),
//         token: _sharedPreferences.getString('token')
//       )
//  }

  Future storeLoginInformation(LoginInfo loginInfo) async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String _loginInfo = jsonEncode(loginInfo);
    await _sharedPreferences.setString('loginInfo', _loginInfo);

  }

  Future<LoginInfo> getLoginInformation() async{
     SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     LoginInfo _loginInfo = LoginInfo.fromJson(jsonDecode(_sharedPreferences.getString('loginInfo')!));
    return _loginInfo;
  }

  Future<bool> isLoggedIn() async{
     SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.containsKey('loginInfo');
  
  }

  Future removeLoginInfo() async{
         SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
        await _sharedPreferences.clear();

  }


}