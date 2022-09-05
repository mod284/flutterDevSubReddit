import '/data_link/comment.dart';

class Post {
  final String postTitle;
  final DateTime publishedDate;
  final String postContent;
  final int numberOfComments;
  final String postCommentsLink;
  List<Comment> postCommentsList= [];


  Post({
    required this.postTitle,
    required this.publishedDate,
    required this.postContent,
    required this.postCommentsLink,
    required this.numberOfComments,
    required List<Comment> postCommentsList,
  });


}
