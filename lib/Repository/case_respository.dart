import 'package:wesafepoliceapp/Dataprovider/case_data_provider.dart';
import 'package:wesafepoliceapp/Models/models.dart';

class CaseRepository {
  final CaseDataProvider dataProvider;

  CaseRepository({
    required this.dataProvider,
  });

  //
  Future<List<Case>> getAssignedPoliceCases() async {
    final _jsonResponse = await dataProvider.getAssignedPoliceCases() as List;

    return _jsonResponse
        .map((caseObject) => Case.fromJson(caseObject))
        .toList();
  }

  // update case
  Future<Case> updateCase(
    Case caseModel, {
    String? imagePath,
    String? videoPath,
    String? voicePath,
    String? discription,
  }) async {
    final _jsonResponse = await dataProvider.updateCase(
      caseModel,
      discription: discription,
      imagePath: imagePath,
      videoPath: videoPath,
      voicePath: voicePath
    );
    return Case.fromJson(_jsonResponse);
  }

  Future<Case> deleteCase(String caseId) async {
    final _jsonResponse = await dataProvider.deleteCase(caseId);
    return Case.fromJson(_jsonResponse);
  }
}
