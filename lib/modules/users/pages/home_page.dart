import 'package:blog_app/modules/posts/pages/post_page.dart';
import 'package:blog_app/modules/users/bloc/user_cubit.dart';
import 'package:blog_app/modules/users/usercases/user_model.dart';
import 'package:blog_app/src/common/api_fetch.dart';
import 'package:blog_app/src/common/navigation_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      lazy: false,
      create: (context) => UserCubit(context.read()),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            context.read<UserCubit>().getUsers();
          } else if ((state as UserStatus).status == Status.LOADING) {
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
              appBar: AppBar(),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            child: TextField(
                              decoration: const InputDecoration(
                                  labelText: "Buscar Cliente"),
                              onChanged: (value) {
                                context
                                    .read<UserCubit>()
                                    .filterUser(value.trim());
                              },
                            ),
                          ),
                        )),
                    Expanded(flex: 5, child: _UserList())
                  ],
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

class _UserList extends StatelessWidget {
  const _UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<UserCubit>().state;
    if ((state as UserStatus).data!.isEmpty) {
      return const Center(
        child: Text("No se encontraron datos del cliente"),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: (state as UserStatus).data!.length,
      itemBuilder: (BuildContext contex, int index) {
        return _UserItem(
          user: (state).data![index],
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _UserItem extends StatelessWidget {
  User? user;
  _UserItem({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // width: double.infinity,
      // height: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user!.name,
                style: TextStyle(
                    color: Colors.green[800], fontWeight: FontWeight.w800),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.phone,
                  color: Colors.green[800],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(user!.phone)
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.email_rounded,
                  color: Colors.green[800],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(user!.email)
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.web_rounded,
                  color: Colors.green[800],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(user!.website)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      pushTopage(context, PostPage(userId: user!.id));
                    },
                    child: const Text(
                      "VER PUBLICACIONES",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
