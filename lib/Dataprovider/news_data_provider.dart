import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:wesafepoliceapp/Models/models.dart';

class NewsDataProvider {
  final http.Client httpClient;
  const NewsDataProvider({required this.httpClient});

  // Fetch all the news availble

  Future<dynamic> fetchAllNews() async {
    late dynamic _jsonResponse;
    try {
      final _response = await httpClient.get(
          Uri.parse('https://we-safe-development.herokuapp.com/api/news/'));

      _jsonResponse = returnResponse(_response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }

  // fetch news by location
  Future<dynamic> fetchAllNewsByLocation() async {
    var _location = await Geolocator.getCurrentPosition();
    late dynamic _jsonResponse;
    try {
      final _response = await httpClient.post(
          Uri.parse(
              'https://we-safe-development.herokuapp.com/api/news/nearby'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "latitude": _location.latitude,
            "longtiude": _location.longitude,
          }));

      _jsonResponse = returnResponse(_response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }
}
