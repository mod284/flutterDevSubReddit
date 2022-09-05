import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:subreddit/data_link/comment.dart';
import 'package:subreddit/data_link/post.dart';

import 'comment_get_test.dart';

String domain = 'https://www.reddit.com';
List<Post> localPostsList = [];

Post fromJson(jsonPost) {
  double epochDate = (jsonPost['data']['created_utc']) * 1000;
  DateTime postDate = DateTime.fromMillisecondsSinceEpoch(epochDate.round());

  return Post(
    postTitle: jsonPost['data']['title'],
    publishedDate: postDate,
    postContent: jsonPost['data']['selftext'],
    postCommentsLink: jsonPost['data']['permalink'],
    numberOfComments: jsonPost['data']['num_comments'],
    postCommentsList: [],
  );
}


Future getPostsApi() async {
  var url = Uri.parse('$domain/r/FlutterDev/hot.json');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  var responseBody = response.body;

  if (response.statusCode == 200) {
    localPostsList.clear();
    Map<String, dynamic> pageMap = convert.jsonDecode(responseBody);
    List jsonPostsList = pageMap['data']['children'];

    for (var post in jsonPostsList) {
      localPostsList.add(
        fromJson(post),
      );
    }

  }
  return responseBody;
}
