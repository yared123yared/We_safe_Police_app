class Address {
  String? city;
  String? subcity;
  String? kebele;
  int? latitude;
  int? longtiude;

  Address({
    this.city,
    this.subcity,
    this.kebele,
    this.latitude,
    this.longtiude,
  });

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    subcity = json['subcity'];
    kebele = json['kebele'];
    latitude = json['latitude'];
    longtiude = json['longtiude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['subcity'] = subcity;
    data['kebele'] = kebele;
    data['latitude'] = latitude;
    data['longtiude'] = longtiude;
    return data;
  }
}
