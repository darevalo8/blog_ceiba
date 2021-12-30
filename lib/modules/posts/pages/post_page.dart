import 'package:blog_app/modules/posts/bloc/post_cubit.dart';
import 'package:blog_app/modules/posts/usercases/post_model.dart';
import 'package:blog_app/src/common/api_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PostPage extends StatelessWidget {
  int userId;
  PostPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(child: Text("$userId"),),
    // );
    return BlocProvider<PostCubit>(
      create: (context) => PostCubit(context.read()),
      child: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostInitial) {
            context.read<PostCubit>().getPosts(userId);
          } else if ((state as PostStatus).status == Status.LOADING) {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          } else if ((state).status == Status.ERROR) {
            return Scaffold(
              body: Center(
                child: Text(state.message!),
              ),
            );
          } else if ((state).status == Status.COMPLETED) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Listado de posts"),
              ),
              body: SafeArea(
                child: Column(
                  children: const [Expanded(child: _PostList())],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<PostCubit>().state;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: (state as PostStatus).data!.length,
      itemBuilder: (BuildContext contex, int index) {
        return _PostItem(
          post: (state).data![index],
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _PostItem extends StatelessWidget {
  Post? post;
  _PostItem({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              post!.title,
              style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.w800),
            ),
            subtitle: Text(post!.body, overflow: TextOverflow.ellipsis,   style: Theme.of(context).textTheme.caption),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.green[800]),
            onTap: () {},
          ),
          const Divider(),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
