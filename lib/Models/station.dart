class Station {
  int? id;
  String? stationName;
  String? city;
  String? subcity;
  String? latitude;
  String? longtiude;

  Station(
      {this.id,
      this.stationName,
      this.city,
      this.subcity,
      this.latitude,
      this.longtiude});

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationName = json['stationName'];
    city = json['city'];
    subcity = json['subcity'];
    latitude = json['latitude'];
    longtiude = json['longtiude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stationName'] = this.stationName;
    data['city'] = this.city;
    data['subcity'] = this.subcity;
    data['latitude'] = this.latitude;
    data['longtiude'] = this.longtiude;
    return data;
  }
}