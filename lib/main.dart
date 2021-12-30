import 'dart:developer';

import 'package:blog_app/modules/users/pages/home_page.dart';
import 'package:blog_app/src/app_bloc_observer.dart';
import 'package:blog_app/src/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(() => null, blocObserver: AppBlocObserver());
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green.shade900,
          secondary: Colors.white
        )),
        home: const HomePage(),
      ),
    );
  }
}
