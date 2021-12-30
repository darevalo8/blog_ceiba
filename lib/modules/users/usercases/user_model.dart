class UserList{
  List<User>? userList = [];
  UserList({this.userList});
  UserList.fromJsonDbList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final user = User.fromMap(item);
      userList!.add(user);
    }
  }
}

class User {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      website: json["website"]);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['phone'] = phone;
    map['website'] = website;

    return map;
  }
  @override
  String toString() {
    return "Usuario $name";
  }
}
