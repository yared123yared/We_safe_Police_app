import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wesafepoliceapp/Models/models.dart';

class CriminalDataProvider {
  final http.Client _httpClient = http.Client();

  // get all The criminals
  Future<dynamic> getAllCriminals() async {
    late dynamic _jsonResponse;
    try {
      final _apiResponse = await _httpClient.get(
        Uri.parse('https://we-safe-development.herokuapp.com/api/criminal/'),
      );

      _jsonResponse = returnResponse(_apiResponse);
    }on SocketException {
      throw FetchDataException('No Internet Connection');

    }
    return _jsonResponse;
  }
}
