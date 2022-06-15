import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wesafepoliceapp/Models/models.dart';
import 'package:wesafepoliceapp/Repository/firebase_storage.dart';

class CaseDataProvider {
  final CustomFirebaseStorageClass _firebaseStorageClass =
      CustomFirebaseStorageClass();
  final http.Client httpClient;
  CaseDataProvider({
    required this.httpClient,
  });

  // get all cases;

  Future<dynamic> getAssignedPoliceCases() async {
    // UserPreference _userPreference = UserPreference();
    // final _preferenceData = _userPreference.getLoginInformation();
    late dynamic _jsonResponse;
    try {
      final _response = await httpClient.get(
        Uri.parse('https://we-safe-development.herokuapp.com/api/case/'),
      );
      _jsonResponse = returnResponse(_response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }

  // update Case

  Future<dynamic> updateCase(Case caseModel,
      {String? imagePath,
      String? videoPath,
      String? voicePath,
      String? discription}) async {
    late dynamic _jsonRespnse;
    String _imagePath = '';
    String _videoPath = '';
    String _voicePath = '';
    String _description = caseModel.evidence!.description!;

    try {
      if (imagePath != '') {
        _imagePath = await _firebaseStorageClass.addFile(imagePath!, 'images');
      }
      if (videoPath != '') {
        _videoPath = await _firebaseStorageClass.addFile(videoPath!, 'videos');
      }
      if (videoPath != '') {
        _voicePath = await _firebaseStorageClass.addFile(voicePath!, 'voices');
      }
      if (discription != '') {
        _description = discription!;
      }

      Attachment _attachment = caseModel.evidence!.attachment!;
      List<Media> _imagesMedia = _attachment.images!;
      List<Media> _voiceMedia = _attachment.voices!;
      List<Media> _videoMedia = _attachment.videos!;

      if (_imagePath != '') {
        _imagesMedia.add(Media(url: _imagePath));
      }
      if (_videoPath != '') {
        _videoMedia.add(
          Media(url: _videoPath),
        );
      }
      if (_voicePath != '') {
        _voiceMedia.add(Media(url: _voicePath));
      }
      Attachment _copiedAttachement = _attachment.copyWith(
        images: _imagesMedia,
        videos: _videoMedia,
        voices: _voiceMedia,
      );

      Evidence _evidence = caseModel.evidence!
          .copyWith(attachment: _copiedAttachement, description: _description);
      Case _case = caseModel.copyWith(evidence: _evidence);

      final _response = await httpClient.put(
          Uri.parse('https://we-safe-development.herokuapp.com/api/case/${caseModel.id}'),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(_case.toJson()));
      _jsonRespnse = returnResponse(_response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonRespnse;
  }

  Future<dynamic> deleteCase(String caseId) async {
    late dynamic _jsonResponse;
    try {
      final _response = await httpClient.delete(Uri.parse(
          'https://we-safe-development.herokuapp.com/api/case/$caseId'));
      _jsonResponse = returnResponse(_response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }
}
