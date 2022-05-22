import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wesafepoliceapp/Config/user_preference.dart';
import 'package:wesafepoliceapp/Models/models.dart';

class CaseDataProvider {
  final http.Client httpClient;
  CaseDataProvider({
    required this.httpClient,
  });

  // get all cases;

  Future<dynamic> getAssignedPoliceCases() async {
    UserPreference _userPreference = UserPreference();
    final _preferenceData = _userPreference.getLoginInformation();
    late dynamic _jsonResponse;
    try {
      final _response = await httpClient.get(
        Uri.parse('https://we-safe-development.herokuapp.com/api/case/'),
      );
      _jsonResponse = returnResponse(_response);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    } 
    return _jsonResponse;
  }

  Future<dynamic> deleteCase(String caseId) async{
    late dynamic _jsonResponse;
    try {
      final _response = await httpClient.delete(Uri.parse('https://we-safe-development.herokuapp.com/api/case/$caseId'));
      _jsonResponse = returnResponse(_response);
      
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }
}
