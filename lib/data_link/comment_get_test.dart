import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:subreddit/data_link/comment.dart';

List nestedRepliesList = [];
List<Comment> commentsList = [];

Future<bool> hasReplies(Map<dynamic, dynamic> jsonDir) async {
  if (jsonDir['data']['replies'] == "") {

    return false;
  } else {
    for (var rep in jsonDir['data']['replies']['data']['children']) {
      nestedRepliesList.add(
        rep,
      );
      hasReplies(rep);
    }
    return true;
  }
}

Future<Comment> commentsFromJson(json) async {
  nestedRepliesList.clear();
  List currentCommentReplies = [];

  hasReplies(json);
  currentCommentReplies.addAll(nestedRepliesList);
  return Comment(
    commentAuthor: json['data']['author'],
    commentContent: json['data']['body'],
    commentRepliesList: currentCommentReplies,
  );
}

String domain = 'https://www.reddit.com';

Future<List<Comment>> getCommentsApi(String commentsUrl) async {
  var url = Uri.parse('$domain$commentsUrl.json');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  var responseBody = response.body;

  if (response.statusCode == 200) {
    var commentsPageList = await convert.jsonDecode(responseBody);
    for (var commentJson in commentsPageList[1]['data']['children']) {
      commentsList.add(
        await commentsFromJson(
          commentJson,
        ),
      );
    }
  }
  return commentsList;
}

Future<String> imageUrlGetter(String authorAboutUrl)async{
  var url = Uri.parse(authorAboutUrl);
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  var responseBody = response.body;
  if (response.statusCode == 200) {
    var authorAboutPage = await convert.jsonDecode(responseBody);
    String authorIconUrl = authorAboutPage['data']['icon_img'];
  return authorIconUrl;
  }
  return 'Not Found';
}