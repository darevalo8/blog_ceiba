
import 'package:blog_app/modules/posts/usercases/post_model.dart';
import 'package:blog_app/modules/posts/usercases/repository.dart';
import 'package:blog_app/src/common/db_service.dart';

class PostUseCase{
  final _repository = PostRepository();

  Future<List<Post>?>getPosts(int userId)async{
    final dbData = await DBProvider.db.selectQuery("post", "userId", userId.toString());
    print("hay data $dbData");
    if(dbData.isEmpty){
      
      List<Post>? postList = await _repository.getPosts(userId);
      if(postList!.isNotEmpty){
          print("net");
        for (var post in postList) {
          await DBProvider.db.insert("post", post.toMap());
        }
        return postList;
      }

    }
    print("db");
    final PostList postList = PostList.fromJsonDbList(dbData);
    return postList.postList;
  }
}