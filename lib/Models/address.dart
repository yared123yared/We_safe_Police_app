
class Address {
    Address({
        this.id,
        this.city,
        this.subcity,
        this.kebele,
        this.latitude,
        this.longtiude,
    });

    int? id;
    String? city;
    String? subcity;
    String? kebele;
    double? latitude;
    double? longtiude;

    Address copyWith({
        int? id,
        String? city,
        String? subcity,
        String? kebele,
        double? latitude,
        double? longtiude,
    }) => 
        Address(
            id: id ?? this.id,
            city: city ?? this.city,
            subcity: subcity ?? this.subcity,
            kebele: kebele ?? this.kebele,
            latitude: latitude ?? this.latitude,
            longtiude: longtiude ?? this.longtiude,
        );

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        city: json["city"],
        subcity: json["subcity"],
        kebele: json["kebele"],
        latitude: json["latitude"],
        longtiude: json["longtiude"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "subcity": subcity,
        "kebele": kebele,
        "latitude": latitude,
        "longtiude": longtiude,
    };
}
