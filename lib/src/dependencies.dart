import 'package:blog_app/modules/posts/usercases/post_usecase.dart';
import 'package:blog_app/modules/users/usercases/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> buildRepositories() {
  return [


    RepositoryProvider<UserUsecase>(create: (_) => UserUsecase()),
    RepositoryProvider<PostUseCase>(create: (_) => PostUseCase()),
    // RepositoryProvider<HomeUsecase>(create: (_) => HomeUsecase()),
    


    
  ];
}