import 'package:http/http.dart' as http;

class PoliceDataProvider{
  final http.Client httpClient;

  PoliceDataProvider({
    required this.httpClient
  });


  Future<dynamic> updatePassword(String currentPassowrd, String newPassword) async{
    
  }


}