import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:wesafepoliceapp/Models/models.dart';

class InvestigateDataProvider {
  final http.Client httpClient;
  const InvestigateDataProvider({required this.httpClient});

  // search image by
  Future<dynamic> getSearchedImages(File imageFile) async {
    late dynamic _jsonResponse;
    try {
      final mimeType =
          lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');

      var dio = Dio();

      // dio.options.headers['content-Type'] = 'application/json';
      final _headers = <String, String>{'content-Type': 'application/json'};
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path,
            filename: fileName,
            contentType: MediaType(mimeType![0], mimeType[1])),
        'remark': 'Image search'
      });
      _jsonResponse = await dio.post(
        'http://192.168.0.36:8000/file/upload/',
        data: formData,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: _headers,
        ),
      );
    } on SocketException catch (e) {
      throw FetchDataException(e.toString());
    }
    return _jsonResponse;
  }

  Future<dynamic> getImageData(File imageData) async {

    String fileName = imageData.path.split('/').last;

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.0.197:8000/file/upload/'));
    request.fields.addAll({'remark': 'search'});
    request.files.add(await http.MultipartFile.fromPath('file', fileName));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {
    }
    return fileName;
  }

  Future<String> upload(File imageFile) async {
    // open a bytestream
    final mimeType =
          lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');
    var stream =
        // ignore: deprecated_member_use
        http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://192.168.0.197:8000/file/upload/");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);
    request.fields.addAll({'remark': 'search'});
    // multipart that takes file
    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(imageFile.path),
      contentType: MediaType(mimeType![0], mimeType[1]),
    );

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    
    // listen for response
    if(response.statusCode == 201){
     String _data =  await response.stream.bytesToString();
    
     return _data.toString();
    }else{
      return 'kdfkdfkd';
    }
    
    
  }
}
