import 'package:blog_app/modules/users/usercases/user_model.dart';
import 'package:blog_app/src/common/api_fetch.dart';

class UserRepository {
  final _helper = ApiBaseHelper();


  Future<List<User>?> getUsers() async {
    final responseData = await _helper.get(
      url: "/users",
    );
    final UserList users = UserList.fromJsonDbList(responseData);
    // print("dataaaaaa ${users.userList}");
    return users.userList;
  }
}