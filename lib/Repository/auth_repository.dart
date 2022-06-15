
import 'package:wesafepoliceapp/Config/user_preference.dart';
import 'package:wesafepoliceapp/Dataprovider/dataprovider.dart';
import 'package:wesafepoliceapp/Models/login_info.dart';
class AuthRepository{
  final AuthDataProvider authDataProvider;

  AuthRepository({
    required this.authDataProvider,
  });

  Future<LoginInfo> login(String phone , String password)async{
    final _apiResponse  = await authDataProvider.login(phone, password);    
    LoginInfo _loginInfo =  LoginInfo.fromJson(_apiResponse);
    
    UserPreference _userPreference = UserPreference();
    await _userPreference.storeLoginInformation(_loginInfo);
    return _loginInfo;
  }

  // reset password
  Future<Police> resetPolicePassword(String newPassword) async{
    final _jsonResponse = await authDataProvider.resetPolicePassword(newPassword);
    return Police.fromJson(_jsonResponse);
  }
} 