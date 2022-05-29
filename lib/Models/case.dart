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

  Case copyWith({
    int? id,
    String? openedDate,
    String? closedDate,
    int? assignedPoliceId,
    AssignedPolice? assignedPolice,
    int? reporterAdminId,
    Person? reporterAdmin,
    Evidence? evidence,
    String? summary,
    String? description,
  }) =>
      Case(
        id: id ?? this.id,
        openedDate: openedDate ?? this.openedDate,
        closedDate: closedDate ?? this.closedDate,
        assignedPoliceId: assignedPoliceId ?? this.assignedPoliceId,
        assignedPolice: assignedPolice ?? this.assignedPolice,
        reporterAdminId: reporterAdminId ?? this.reporterAdminId,
        reporterAdmin: reporterAdmin ?? this.reporterAdmin,
        evidence: evidence ?? this.evidence,
        summary: summary ?? this.summary,
        description: description ?? this.description,
      );

  Case.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    openedDate = json['openedDate'];
    closedDate = json['closedDate'];
    assignedPoliceId = json['assignedPoliceId'];
    assignedPolice = json['assignedPolice'] != null
        ? AssignedPolice.fromJson(json['assignedPolice'])
        : null;
    reporterAdminId = json['reporterAdminId'];
    reporterAdmin = json['reporterAdmin'] != null
        ? Person.fromJson(json['reporterAdmin'])
        : null;
    evidence =
        json['evidence'] != null ? Evidence.fromJson(json['evidence']) : null;
    summary = json['summary'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['openedDate'] = openedDate;
    data['closedDate'] = closedDate;
    data['assignedPoliceId'] = assignedPoliceId;
    if (assignedPolice != null) {
      data['assignedPolice'] = assignedPolice!.toJson();
    }
    data['reporterAdminId'] = reporterAdminId;
    if (reporterAdmin != null) {
      data['reporterAdmin'] = reporterAdmin!.toJson();
    }
    if (evidence != null) {
      data['evidence'] = evidence!.toJson();
    }
    data['summary'] = summary;
    data['description'] = description;
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
        json['station'] != null ? Station.fromJson(json['station']) : null;
    person = json['person'] != null ? Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['experiance'] = experiance;
    data['level'] = level;
    data['stationId'] = stationId;
    if (station != null) {
      data['station'] = station!.toJson();
    }
    if (person != null) {
      data['person'] = person!.toJson();
    }
    return data;
  }
}

class Evidence {
  int? id;
  String? description;
  Attachment? attachment;

  Evidence({this.id, this.description, this.attachment});
  Evidence copyWith({
    int? id,
    String? description,
    Attachment? attachment,
  }) =>
      Evidence(
        id: id ?? this.id,
        description: description ?? this.description,
        attachment: attachment ?? this.attachment,
      );

  Evidence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    attachment = json['attachment'] != null
        ? Attachment.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    if (attachment != null) {
      data['attachment'] = attachment!.toJson();
    }
    return data;
  }
}

class Attachment {
  int? id;
  List<Media>? images;
  List<Media>? voices;
  List<Media>? videos;

  Attachment({
    this.id,
    this.images,
    this.voices,
    this.videos,
  });

  Attachment copyWith({
        int? id,
        List<Media>? images,
        List<Media>?voices,
        List<Media>? videos,
    }) => 
        Attachment(
            id: id ?? this.id,
            images: images ?? this.images,
            voices: voices ?? this.voices,
            videos: videos ?? this.videos,
        );

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['images'] != null) {
      images = <Media>[];
      json['images'].forEach((v) {
        images!.add(Media.fromJson(v));
      });
    }
    if (json['voices'] != null) {
      voices = <Media>[];
      json['voices'].forEach((v) {
        voices!.add(Media.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <Media>[];
      json['videos'].forEach((v) {
        videos!.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (voices != null) {
      data['voices'] = voices!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['url'] = url;
    return data;
  }
}
