import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wesafepoliceapp/Models/models.dart';

class UserAlertDataProvider{
  final http.Client httpClient;

  UserAlertDataProvider({required this.httpClient});

  // get alerts
  Future<dynamic> getAlerts() async{
     late dynamic _jsonResponse;
     try {
       final _response = await httpClient.get(Uri.parse(
         'https://we-safe-development.herokuapp.com/api/alerts'
       ));

       _jsonResponse = returnResponse(_response);
     } on SocketException{
       throw FetchDataException('Not Internet connection');
     }
    return _jsonResponse;
  }

  

}