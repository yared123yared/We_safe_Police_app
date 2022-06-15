class Role {
    Role({
        this.id,
        this.roleName,
    });

    int? id;
    String? roleName;

    Role copyWith({
        int? id,
        String? roleName,
    }) => 
        Role(
            id: id ?? this.id,
            roleName: roleName ?? this.roleName,
        );

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        roleName: json["roleName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
    };
}
