import 'package:bloc/bloc.dart';
import 'package:blog_app/modules/users/usercases/user_model.dart';
import 'package:blog_app/modules/users/usercases/user_usecase.dart';
import 'package:blog_app/src/common/api_fetch.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserUsecase _userUsecase;
  UserCubit(this._userUsecase) : super(UserInitial());

  void getUsers ()async{
    
    try {
      emit(UserStatus.loading());
      final data = await _userUsecase.getUsers();
      emit(UserStatus.completed(data));
    } on AppException catch (ex) {
      emit(UserStatus.error(ex.message));
    }
    
  }

  void filterUser(String cliente)async{
    try {
      final data = await _userUsecase.filterUser(cliente);
      emit(UserStatus.completed(data));
    } on AppException catch (ex) {
      emit(UserStatus.error(ex.message));
    }

  }

}
