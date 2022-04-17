import 'package:wesafepoliceapp/Models/address.dart';
import 'package:wesafepoliceapp/Models/role.dart';

class Person {
    Person({
        this.personId,
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

    int? personId;
    String? firstName;
    String ?lastName;
    String? password;
    String? phone;
    String? picture;
    String? sex;
    Address? address;
    int? roleId;
    Role? role;

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        personId: json["personId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        password: json["password"],
        phone: json["phone"],
        picture: json["picture"],
        sex: json["sex"],
        // address: json["address"],
        roleId: json["roleId"],
        role: Role.fromJson(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "personId": personId,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "phone": phone,
        "picture": picture,
        "sex": sex,
        "address": address,
        "roleId": roleId,
        "role": role!.toJson(),
    };
}

