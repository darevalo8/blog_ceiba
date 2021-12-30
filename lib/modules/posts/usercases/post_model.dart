class PostList{
  List<Post>? postList = [];
  PostList({this.postList});
  PostList.fromJsonDbList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final user = Post.fromMap(item);
      postList!.add(user);
    }
  }
}

class Post{
  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
  });


  factory Post.fromMap(Map<String, dynamic> json) => Post(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"]);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    map['userId'] = userId;
    return map;
  }
  @override
  String toString() {
    return "Usuario $title";
  }
}