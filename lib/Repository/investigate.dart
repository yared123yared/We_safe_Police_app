

import 'dart:io';
import 'dart:convert';

import 'package:wesafepoliceapp/Dataprovider/investigate.dart';

class InvestigateRepository{
  final InvestigateDataProvider dataProvider;
  const InvestigateRepository({required this.dataProvider});

    Future<List<String>> getSearchedImages(File imageFile) async {
      final _response = await dataProvider.upload(imageFile);
      final _data = convert(_response);
      return _data.map((image) => image.toString()).toList();

    }
}

List convert(String input) {
  List output;
  try {
    output = json.decode(input);
    return output;
  } catch (err) {
    return [];
  }
}