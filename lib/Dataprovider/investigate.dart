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

  
  Future<String> upload(File imageFile) async {
    print("Uploading images ");
    // open a bytestream
    final mimeType =
          lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');
    var stream =
        // ignore: deprecated_member_use
        http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://192.168.183.86:8000/file/upload/");

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
     print('The images  is');
     print(_data);
    
     return _data.toString();
    }else{
      return 'kdfkdfkd';
    }
    
    
  }
}
