import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/custom_app_bar.dart';
import '/data_link/post.dart';
import '/data_link/post_get.dart';
import '/logic/theme_cubit.dart';
import '/presentation/posts_page.dart';
import '../data_link/post_get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List commentsList = [];
Text appBarTitle = const Text(
  "Reddit",
  style: TextStyle(
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
);

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBarContent(),
      body: body(),
    );
  }

  PreferredSize _appBarContent() => PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.24,
        ),
        child: ClipPath(
          clipper: CustomAppBar(),
          child: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 40, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    appBarTitle,
                    _themeButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _themeButton() {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(
      context,
      listen: false,
    );
    return IconButton(
      onPressed: () {
        theme.changTheme();
      },
      icon: theme.darkTheme
          ? const Icon(
              Icons.light_mode_outlined,
              size: 35,
              color: Colors.white,
            )
          : const Icon(
              Icons.dark_mode_outlined,
              size: 35,
              color: Colors.white,
            ),
    );
  }

  Widget body() => Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.17,
          ),
          headers(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          _futurePostsList(),
        ],
      );

  Widget headers() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const <Widget>[
          Text(
            'Hot Posts',
            style: TextStyle(
              color: Color.fromARGB(255, 200, 0, 0),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Elusive.fire,
            color: Color.fromARGB(255, 200, 0, 0),
            size: 40,
          ),
        ],
      );

  Widget _futurePostsList() => FutureBuilder(
        future: getPostsApi(),
        builder: (context, snapShot) => snapShot.hasData
            ? Flexible(
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: localPostsList.length,
                    itemBuilder: (context, index) {
                      Post currentPost = localPostsList[index];
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          shadowColor: Colors.black,
                          elevation: 8,
                          child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  localPostsList[index].postTitle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '${localPostsList[index].publishedDate}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  localPostsList[index].postContent,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  maxLines: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    const Icon(
                                      FontAwesomeIcons.comment,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Text(
                                      "${localPostsList[index].numberOfComments}",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostsPage(currentPost),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
      );
}
