import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CustomFirebaseStorageClass {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> addFile(String imagePath, String tag) async {
    String fileName = imagePath
        .substring(imagePath.lastIndexOf('/'), imagePath.lastIndexOf('.'))
        .replaceAll('/', '');
    File _file = File(imagePath);
    final _fileName = basename(_file.path);
    final _destination = '$tag/$_fileName';
     String _fileLink = '';
    try {
      final _ref = _storage.ref().child(_destination);
      final _response = await _ref.putFile(_file);
      if (_response.state == TaskState.success) {
        final String _downloadUrl = await _response.ref.getDownloadURL();
        _fileLink = _downloadUrl;

        debugPrint('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
        debugPrint(_downloadUrl);
        await _firestore
            .collection(tag)
            .add({'url': _downloadUrl, 'name': fileName}).then((value) {
        }).onError((error, stackTrace) {
        
        });
      } else {
        throw Exception(_response.state.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return _fileLink;
  }

  
}
