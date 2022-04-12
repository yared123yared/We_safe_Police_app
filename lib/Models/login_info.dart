// To parse this JSON data, do
//
//     final loginInfo = loginInfoFromJson(jsonString);

import 'dart:convert';

import 'package:wesafepoliceapp/Models/person.dart';

LoginInfo loginInfoFromJson(String str) => LoginInfo.fromJson(json.decode(str));

String loginInfoToJson(LoginInfo data) => json.encode(data.toJson());

class LoginInfo {
    LoginInfo({
        this.person,
        this.token,
    });

    Person? person;
    String? token;

    factory LoginInfo.fromJson(Map<String, dynamic> json) => LoginInfo(
        person: Person.fromJson(json["person"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "person": person!.toJson(),
        "token": token,
    };
}

