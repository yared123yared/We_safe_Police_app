class Address {
  int? id;
  String? city;
  String? subcity;
  String? kebele;
  double? latitude;
  double? longtiude;

  Address(
      {this.id,
      this.city,
      this.subcity,
      this.kebele,
      this.latitude,
      this.longtiude});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    subcity = json['subcity'];
    kebele = json['kebele'];
    latitude = json['latitude'];
    longtiude = json['longtiude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['subcity'] = subcity;
    data['kebele'] = kebele;
    data['latitude'] = latitude;
    data['longtiude'] = longtiude;
    return data;
  }
}