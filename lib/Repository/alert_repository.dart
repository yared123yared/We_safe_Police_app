

import 'package:wesafepoliceapp/Dataprovider/user_alert_data_provider.dart';
import 'package:wesafepoliceapp/Models/alert_model.dart';

class UserAlertRepository{
  final UserAlertDataProvider dataProvider;
  UserAlertRepository({required this.dataProvider});

  // get all alerts
  Future<List<UserAlert>> getAllAlerts() async{
    final _jsonResponse = await dataProvider.getAlerts() as List;
    return _jsonResponse.map((alerts) => UserAlert.fromJson(alerts)).toList();
  }
}