import 'package:wesafepoliceapp/Models/address.dart';
import 'package:wesafepoliceapp/Models/role.dart';

class Person {
    Person({
        this.id,
        this.firstName,
        this.lastName,
        this.password,
        this.phone,
        this.picture,
        this.sex,
        this.address,
        this.roleId,
        this.role,
    });

    int? id;
    String? firstName;
    String? lastName;
    String? password;
    String? phone;
    String? picture;
    String? sex;
    Address? address;
    int? roleId;
    Role? role;

    Person copyWith({
        int? id,
        String? firstName,
        String? lastName,
        String? password,
        String? phone,
        String? picture,
        String? sex,
        Address? address,
        int? roleId,
        Role? role,
    }) => 
        Person(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            password: password ?? this.password,
            phone: phone ?? this.phone,
            picture: picture ?? this.picture,
            sex: sex ?? this.sex,
            address: address ?? this.address,
            roleId: roleId ?? this.roleId,
            role: role ?? this.role,
        );

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        password: json["password"],
        phone: json["phone"],
        picture: json["picture"],
        sex: json["sex"],
        address: Address.fromJson(json["address"]),
        roleId: json["roleId"],
        role: Role.fromJson(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "phone": phone,
        "picture": picture,
        "sex": sex,
        "address": address!.toJson(),
        "roleId": roleId,
        "role": role!.toJson(),
    };
}
