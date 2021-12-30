import 'package:blog_app/modules/users/usercases/repository.dart';
import 'package:blog_app/modules/users/usercases/user_model.dart';
import 'package:blog_app/src/common/db_service.dart';

class UserUsecase{
  final _repository = UserRepository();

  Future<List<User>?>getUsers()async{
    final dbData = await DBProvider.db.selectOrderAll('user');
    if(dbData.isEmpty){
      
      List<User>? clientList = await _repository.getUsers();
      if(clientList!.isNotEmpty){
        for (var client in clientList) {
          await DBProvider.db.insert("user", client.toMap());
        }
        return clientList;
      }

    }
    final UserList users = UserList.fromJsonDbList(dbData);
    return users.userList;
  }

  Future<List<User>?>filterUser(String name)async{
    final dbData = await DBProvider.db.likeQuery("user", "name", "%$name%");
    final UserList users = UserList.fromJsonDbList(dbData);
    return users.userList;
  }
}