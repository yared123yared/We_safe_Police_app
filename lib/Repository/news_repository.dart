

import 'package:wesafepoliceapp/Dataprovider/news_data_provider.dart';
import 'package:wesafepoliceapp/Models/new_model.dart';

class NewsRespository{
  final NewsDataProvider dataProvider;
  const NewsRespository({required this.dataProvider});

  // Fetch all the news availble
  Future<List<NewsModel>> fetchAllNews() async{
    final _jsonResponse = await dataProvider.fetchAllNews() as List;

    return _jsonResponse.map((newsJson) => NewsModel.fromJson(newsJson)).toList();
  }
}