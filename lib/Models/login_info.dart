import 'package:wesafepoliceapp/Models/station.dart';
import 'dart:convert';

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
// To parse this JSON data, do
//
//     final police = policeFromJson(jsonString);


Police policeFromJson(String str) => Police.fromJson(json.decode(str));

String policeToJson(Police data) => json.encode(data.toJson());

class Police {
    Police({
        this.id,
        this.experiance,
        this.level,
        this.stationId,
        this.station,
        this.person,
    });

    int? id;
    int? experiance;
    int? level;
    int? stationId;
    Station? station;
    Person? person;

    Police copyWith({
        int? id,
        int? experiance,
        int? level,
        int? stationId,
        Station? station,
        Person? person,
    }) => 
        Police(
            id: id ?? this.id,
            experiance: experiance ?? this.experiance,
            level: level ?? this.level,
            stationId: stationId ?? this.stationId,
            station: station ?? this.station,
            person: person ?? this.person,
        );

    factory Police.fromJson(Map<String, dynamic> json) => Police(
        id: json["id"],
        experiance: json["experiance"],
        level: json["level"],
        stationId: json["stationId"],
        station: Station.fromJson(json["station"]),
        person: Person.fromJson(json["person"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "experiance": experiance,
        "level": level,
        "stationId": stationId,
        "station": station!.toJson(),
        "person": person!.toJson(),
    };
}








