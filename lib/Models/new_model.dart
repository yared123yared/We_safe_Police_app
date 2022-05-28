
class NewsModel {
  int? id;
  String? title;
  String? subTitle;
  String? body;
  String? video;
  String? image;
  String? postedDate;
  String? latitude;
  String? longtiude;

  NewsModel(
      {this.id,
      this.title,
      this.subTitle,
      this.body,
      this.video,
      this.image,
      this.postedDate,
      this.latitude,
      this.longtiude});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['subTitle'];
    body = json['body'];
    video = json['video'];
    image = json['image'];
    postedDate = json['postedDate'];
    latitude = json['latitude'];
    longtiude = json['longtiude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['body'] = body;
    data['video'] = video;
    data['image'] = image;
    data['postedDate'] = postedDate;
    data['latitude'] = latitude;
    data['longtiude'] = longtiude;
    return data;
  }
}