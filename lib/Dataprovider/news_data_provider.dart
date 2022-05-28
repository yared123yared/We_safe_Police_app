import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wesafepoliceapp/Models/models.dart';


class NewsDataProvider{
  final http.Client httpClient;
  const NewsDataProvider({required this.httpClient});

  // Fetch all the news availble

  Future<dynamic> fetchAllNews() async{
    late dynamic _jsonResponse;
    try {

      final _response = await httpClient.get(Uri.parse('https://we-safe-development.herokuapp.com/api/news/'));

      _jsonResponse = returnResponse(_response);
      
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }
}