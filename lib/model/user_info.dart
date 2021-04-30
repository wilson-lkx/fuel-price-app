class UserInfo {
  final int id;
  final int userId;
  final String userFirstName;
  final String userLastName;

  UserInfo({this.id, this.userId, this.userFirstName, this.userLastName});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      userId: json['userId'],
      userFirstName: json['userFirstName'],
      userLastName: json['userLastName'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['userId'] = this.userId;
    data['userFirstName'] = this.userFirstName;
    data['userLastName'] = this.userLastName;
    return data;
  }
}