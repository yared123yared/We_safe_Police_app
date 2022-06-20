// class UserInfo{
//   final String userName;
//   final String connectionId;
//   UserInfo({required this.userName, required this.connectionId});
// }
class UserInfo {
  String? userName;
  String? connectionId;

  UserInfo({this.userName, this.connectionId});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    connectionId = json['connectionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['connectionId'] = this.connectionId;
    return data;
  }
}