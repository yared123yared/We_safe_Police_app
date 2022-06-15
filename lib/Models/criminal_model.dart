class CriminalModel {
  int? id;
  String? firstName;
  String? lastName;
  List<Images>? images;
  String? description;

  CriminalModel(
      {this.id, this.firstName, this.lastName, this.images, this.description});

  CriminalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    return data;
  }
}

class Images {
  int? id;
  String? url;

  Images({this.id, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}