import 'package:wesafepoliceapp/Models/station.dart';

import 'person.dart';
class LoginInfo {
  Police? police;
  String? token;

  LoginInfo({ this.police, this.token});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    
    police =
        json['police'] != null ? Police.fromJson(json['police']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (police != null) {
      data['police'] = police!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Police {
  int? id;
  int? experiance;
  int? level;
  int? stationId;
  Station? station;
  Person? person;

  Police(
      {this.id,
      this.experiance,
      this.level,
      this.stationId,
      this.station,
      this.person});

  Police.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    experiance = json['experiance'];
    level = json['level'];
    stationId = json['stationId'];
    station =
        json['station'] != null ? Station.fromJson(json['station']) : null;
    person =
        json['person'] != null ? Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['experiance'] = experiance;
    data['level'] = level;
    data['stationId'] = stationId;
    if (station != null) {
      data['station'] = station!.toJson();
    }
    if (person != null) {
      data['person'] = person!.toJson();
    }
    return data;
  }
}




