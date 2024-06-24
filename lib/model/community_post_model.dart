// import 'package:sihproject/service/date_format.dart';

import 'package:kritrima_tattva/service/date_format.dart';

class CommunityPost {
  final String userId;
  final String question;
  final String description;
  final String imageUrl;
  final String postId;
  final String username;
  final String userImage;
  final List<dynamic> likes;
  final List<dynamic> dislikes;
  final List<dynamic> answers;
  final String timestamp;

  CommunityPost({
    required this.userId,
    required this.question,
    required this.description,
    required this.imageUrl,
    required this.postId,
    required this.username,
    required this.userImage,
    required this.likes,
    required this.dislikes,
    required this.answers,
    required this.timestamp,
  });
  factory CommunityPost.fromMap(Map<String, dynamic> map) {
    return CommunityPost(
      userId: map['userId'],
      question: map['question'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      postId: map['postid'],
      username: map['username'],
      userImage: map['userImage'],
      likes: List<dynamic>.from(map['likes']),
      dislikes: List<dynamic>.from(map['dislikes']),
      answers: List<dynamic>.from(map['answer']),
      timestamp: CustomFunction.formatDateTime(map['timestamp'].toDate()),
    );
  }
}
