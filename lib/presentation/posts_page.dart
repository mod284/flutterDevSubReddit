import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/data_link/comment_get_test.dart';
import '/data_link/post.dart';
import '../data_link/comment.dart';
import 'components/custom_app_bar.dart';

Text appBarTitle = const Text(
  "Reddit",
  style: TextStyle(
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
);

class PostsPage extends StatefulWidget {
  const PostsPage(this.postData, {Key? key}) : super(key: key);
  final Post postData;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
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
                padding: const EdgeInsets.fromLTRB(50, 60, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    appBarTitle,
                    _backButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _backButton() => TextButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
        ),
        onPressed: () => Navigator.pop(context),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            const Text(
              "Back",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );

  Widget body() => Container(
        color: const Color.fromARGB(0, 20, 20, 20),
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.175,
            ),
            _pageHeader(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            _postInfoFunction(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            _commentsHeader(),
            _commentListApi(),
          ],
        ),
      );

  Widget _pageHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const <Widget>[
          Text(
            'Hot Posts',
            style: TextStyle(
                color: Color.fromARGB(255, 200, 0, 0),
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            Elusive.fire,
            color: Color.fromARGB(255, 200, 0, 0),
            size: 40,
          ),
        ],
      );

  Widget _postInfoFunction() => Flexible(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(25),
              shadowColor: Colors.black,
              elevation: 12,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.postData.postTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${widget.postData.publishedDate}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.postData.postContent,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
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
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "${widget.postData.numberOfComments}",
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _commentsHeader() => SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "Comments",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget _commentListApi() => FutureBuilder(
        future: getCommentsApi(widget.postData.postCommentsLink),
        builder: (context, snapShot) => snapShot.hasData
            ? Flexible(
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: commentsList.length,
                    itemBuilder: (context, index) {
                      Comment currentComment = commentsList[index];
                      return Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                        child: ListTile(
                          title: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 58,
                                    width: 58,
                                    child: CircleAvatar(
                                      foregroundImage: AssetImage(
                                          "assets/images/vector.png"),
                                      radius: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    currentComment.commentAuthor,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.22,
                                      )
                                    ],
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Text(
                                            currentComment.commentContent,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: commentReplies(currentComment),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                        ),
                                        const Divider(
                                          height: 5,
                                          thickness: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
      );

  Widget commentReplies(Comment currentComment) =>
      currentComment.commentRepliesList.isEmpty
          ? Container(
              height: 0.001,
            )
          : SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: currentComment.commentRepliesList.length,
                itemBuilder: (context, repIndex) => Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0 *
                              (currentComment.commentRepliesList[repIndex]
                                      ['data']['depth'] -
                                  1),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.08,
                          child: const CircleAvatar(
                            backgroundImage: AssetImage("assets/images/vector.png"),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Flexible(
                          child: Text(
                            '${currentComment.commentRepliesList[repIndex]['data']['author']}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10.0 *
                              (currentComment.commentRepliesList[repIndex]
                              ['data']['depth'] -
                                  1),
                        ),
                        Flexible(
                          child: Text(
                            "${currentComment.commentRepliesList[repIndex]['data']['body']}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      height: 5,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            );
}
