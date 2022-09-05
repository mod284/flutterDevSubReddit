import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/logic/theme_cubit.dart';

import '/presentation/home_page.dart';
import 'data_link/post.dart';


Future <void> main () async {
  runApp(
      BlocProvider(
        create: (context) => ThemeCubit(),
        child: const SubReddit(),
      ),
    );
}

Post newPost = Post(
  postTitle: "title of post",
  postContent: "the content of the post witch contain many many "
      "many of feelings and people hopes etc...",
  publishedDate: DateTime.now(),
  postCommentsLink: '',
  numberOfComments: 0,
  postCommentsList: [],

);

class SubReddit extends StatelessWidget {
  const SubReddit({Key? key}) : super(key: key);
  final title = 'Reddit';

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(
      context,
      listen: true,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: theme.darkTheme ? ThemeMode.dark : ThemeMode.light,
      // themeMode:  ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(
          255,
          43,
          87,
          147,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(
          255,
          66,
          66,
          66,
        ),
      ),
      // theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      title: title,

      // home:  PostsPage(newPost),
      home: const HomePage(),
    );
  }
}
