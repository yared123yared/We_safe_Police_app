import 'package:wesafepoliceapp/Models/models.dart';
import 'package:wesafepoliceapp/Models/station.dart';

class Case {
  int? id;
  String? openedDate;
  String? closedDate;
  int? assignedPoliceId;
  AssignedPolice? assignedPolice;
  int? reporterAdminId;
  Person? reporterAdmin;
  Evidence? evidence;
  String? summary;
  String? description;

  Case(
      {this.id,
      this.openedDate,
      this.closedDate,
      this.assignedPoliceId,
      this.assignedPolice,
      this.reporterAdminId,
      this.reporterAdmin,
      this.evidence,
      this.summary,
      this.description});

  Case.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    openedDate = json['openedDate'];
    closedDate = json['closedDate'];
    assignedPoliceId = json['assignedPoliceId'];
    assignedPolice = json['assignedPolice'] != null
        ? new AssignedPolice.fromJson(json['assignedPolice'])
        : null;
    reporterAdminId = json['reporterAdminId'];
    reporterAdmin = json['reporterAdmin'] != null
        ? new Person.fromJson(json['reporterAdmin'])
        : null;
    evidence = json['evidence'] != null
        ? new Evidence.fromJson(json['evidence'])
        : null;
    summary = json['summary'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['openedDate'] = this.openedDate;
    data['closedDate'] = this.closedDate;
    data['assignedPoliceId'] = this.assignedPoliceId;
    if (this.assignedPolice != null) {
      data['assignedPolice'] = this.assignedPolice!.toJson();
    }
    data['reporterAdminId'] = this.reporterAdminId;
    if (this.reporterAdmin != null) {
      data['reporterAdmin'] = this.reporterAdmin!.toJson();
    }
    if (this.evidence != null) {
      data['evidence'] = this.evidence!.toJson();
    }
    data['summary'] = this.summary;
    data['description'] = this.description;
    return data;
  }
}

class AssignedPolice {
  int? id;
  int? experiance;
  int? level;
  int? stationId;
  Station? station;
  Person? person;

  AssignedPolice(
      {this.id,
      this.experiance,
      this.level,
      this.stationId,
      this.station,
      this.person});

  AssignedPolice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    experiance = json['experiance'];
    level = json['level'];
    stationId = json['stationId'];
    station =
        json['station'] != null ? new Station.fromJson(json['station']) : null;
    person =
        json['person'] != null ? new Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['experiance'] = this.experiance;
    data['level'] = this.level;
    data['stationId'] = this.stationId;
    if (this.station != null) {
      data['station'] = this.station!.toJson();
    }
    if (this.person != null) {
      data['person'] = this.person!.toJson();
    }
    return data;
  }
}





class Evidence {
  int? id;
  String? description;
  Attachment? attachment;

  Evidence({this.id, this.description, this.attachment});

  Evidence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    attachment = json['attachment'] != null
        ? new Attachment.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.toJson();
    }
    return data;
  }
}

class Attachment {
  int? id;
  List<Media>? images;
  List<Media>? voices;
  List<Media>? videos;

  Attachment({this.id, this.images, this.voices, this.videos});

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['images'] != null) {
      images = <Media>[];
      json['images'].forEach((v) {
        images!.add(new Media.fromJson(v));
      });
    }
    if (json['voices'] != null) {
      voices = <Media>[];
      json['voices'].forEach((v) {
        voices!.add(new Media.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <Media>[];
      json['videos'].forEach((v) {
        videos!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.voices != null) {
      data['voices'] = this.voices!.map((v) => v.toJson()).toList();
    }
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int? id;
  String? url;

  Media({this.id, this.url});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}