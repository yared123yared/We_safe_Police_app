class Station {
    Station({
        this.id,
        this.stationName,
        this.city,
        this.subcity,
        this.latitude,
        this.longtiude,
    });

    int? id;
    String? stationName;
    String? city;
    String? subcity;
    String? latitude;
    String? longtiude;

    Station copyWith({
        int? id,
        String? stationName,
        String? city,
        String? subcity,
        String? latitude,
        String? longtiude,
    }) => 
        Station(
            id: id ?? this.id,
            stationName: stationName ?? this.stationName,
            city: city ?? this.city,
            subcity: subcity ?? this.subcity,
            latitude: latitude ?? this.latitude,
            longtiude: longtiude ?? this.longtiude,
        );

    factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json["id"],
        stationName: json["stationName"],
        city: json["city"],
        subcity: json["subcity"],
        latitude: json["latitude"],
        longtiude: json["longtiude"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stationName": stationName,
        "city": city,
        "subcity": subcity,
        "latitude": latitude,
        "longtiude": longtiude,
    };
}