class Role {
    Role({
        this.roleId,
        this.roleName,
    });

    int? roleId;
    String? roleName;

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        roleName: json["roleName"],
    );

    Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
    };
}
