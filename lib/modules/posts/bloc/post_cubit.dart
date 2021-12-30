import 'package:bloc/bloc.dart';
import 'package:blog_app/modules/posts/usercases/post_model.dart';
import 'package:blog_app/modules/posts/usercases/post_usecase.dart';
import 'package:blog_app/src/common/api_fetch.dart';
import 'package:meta/meta.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostUseCase _postUseCase;
  PostCubit(this._postUseCase) : super(PostInitial());

  void getPosts (int userId)async{
    
    try {
      emit(PostStatus.loading());
      final data = await _postUseCase.getPosts(userId);
      emit(PostStatus.completed(data));
    } on AppException catch (ex) {
      emit(PostStatus.error(ex.message));
    }
    
  }
}
