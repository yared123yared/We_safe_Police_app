class UserAlert {
  int? id;
  double? latitude;
  double? longtiude;
  double? distance;
  int? userId;
  AlertedBy? alertedBy;

  UserAlert(
      {this.id,
      this.latitude,
      this.longtiude,
      this.distance,
      this.userId,
      this.alertedBy});

  UserAlert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longtiude = json['longtiude'];
    distance = json['distance'];
    userId = json['userId'];
    alertedBy = json['alertedBy'] != null
        ? AlertedBy.fromJson(json['alertedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['latitude'] = latitude;
    data['longtiude'] = longtiude;
    data['distance'] = distance;
    data['userId'] = userId;
    if (alertedBy != null) {
      data['alertedBy'] = alertedBy!.toJson();
    }
    return data;
  }
}

class AlertedBy {
  int? id;
  String? identificationCard;
  Person? person;

  AlertedBy({this.id, this.identificationCard, this.person});

  AlertedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identificationCard = json['identificationCard'];
    person =
        json['person'] != null ? Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['identificationCard'] = identificationCard;
    if (person != null) {
      data['person'] = person!.toJson();
    }
    return data;
  }
}

class Person {
  int? id;
  String? firstName;
  String? lastName;
  String? password;
  String? phone;
  String? picture;
  String? sex;

  Person(
      {this.id,
      this.firstName,
      this.lastName,
      this.password,
      this.phone,
      this.picture,
      this.sex});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    phone = json['phone'];
    picture = json['picture'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['password'] = password;
    data['phone'] = phone;
    data['picture'] = picture;
    data['sex'] = sex;
    return data;
  }
}