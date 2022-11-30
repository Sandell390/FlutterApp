class User {
  String? Username;
  String? Avatar;
  User({this.Avatar, this.Username});

  User.fromJson(dynamic json) {
    Username = json["username"];
    Avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = Username;
    data['avatar'] = Avatar;
    return data;
  }
}
