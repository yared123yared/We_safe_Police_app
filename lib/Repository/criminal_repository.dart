import 'package:wesafepoliceapp/Dataprovider/criminal_data_provider.dart';
import 'package:wesafepoliceapp/Models/criminal_model.dart';


class CriminalRepository {
  final CriminalDataProvider _criminalDataProvider = CriminalDataProvider();

  // get all ciminals 
  Future<List<CriminalModel>> getAllCriminals() async{
    final _jsonResponse = await _criminalDataProvider.getAllCriminals() as List;
    return _jsonResponse.map((_criminalJson) => CriminalModel.fromJson(_criminalJson)).toList();
  }

}