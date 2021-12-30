import 'package:blog_app/modules/posts/usercases/post_model.dart';

import 'package:blog_app/src/common/api_fetch.dart';

class PostRepository {
  final _helper = ApiBaseHelper();


  Future<List<Post>?> getPosts(int userId) async {
    print("legas");
    final responseData = await _helper.get(
      url: "/posts",
      params: {
        "userId": userId.toString()
      }
    );
    final PostList postList = PostList.fromJsonDbList(responseData);

    return postList.postList;
    // return [];
  }
}