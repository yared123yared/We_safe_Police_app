

import 'package:wesafepoliceapp/Dataprovider/case_data_provider.dart';
import 'package:wesafepoliceapp/Models/models.dart';

class CaseRepository{
  final CaseDataProvider dataProvider;

  CaseRepository({
    required this.dataProvider,
  });

  // 
  Future<List<Case>> getAssignedPoliceCases() async{
    final _jsonResponse = await dataProvider.getAssignedPoliceCases() as List;

    return _jsonResponse.map((caseObject) => Case.fromJson(caseObject)).toList();

  }

  Future<Case> deleteCase(String caseId) async{
    final _jsonResponse = await dataProvider.deleteCase(caseId);
    return Case.fromJson(_jsonResponse);
  }
}