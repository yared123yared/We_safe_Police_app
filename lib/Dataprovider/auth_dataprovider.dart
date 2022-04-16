import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wesafepoliceapp/Config/user_preference.dart';
import 'package:wesafepoliceapp/Models/api/api_exception.dart';
import 'package:wesafepoliceapp/Models/api/api_response.dart';
import 'package:wesafepoliceapp/Utils/constants.dart';
import 'package:flutter/material.dart';

class AuthDataProvider {
  final http.Client httpClient;

  AuthDataProvider({
    required this.httpClient,
  });

  Future<dynamic> login(String phone, String password) async {
    debugPrint('phone login is $phone');
    debugPrint('password login is $password');

    late dynamic _authResponse;
    try {
      final _apiResponse = await httpClient.post(
        Uri.parse(BASE_URL + '/api/persons/authenticate'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: jsonEncode(
          {
           "phone":phone,
           "password": password
        }
        )
      );
      debugPrint('The status code is${_apiResponse.statusCode}');
      debugPrint(_apiResponse.body);
      _authResponse = returnResponse(_apiResponse);

    } on SocketException catch(error){
      throw FetchDataException("No Internet connection");
    }
     catch (e) {
      throw Exception(e.toString());
    }
    return _authResponse;
  }
}