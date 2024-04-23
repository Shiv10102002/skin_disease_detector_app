import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sihproject/model/community_post_model.dart';
import 'package:sihproject/service/date_format.dart';

class PostController extends GetxController {
  // var isLike = false.obs;
  // var isDislike = false.obs;
  final RxList<CommunityPost> communityPosts = <CommunityPost>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCommunityPosts();
  }

  void fetchCommunityPosts() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('CommunityPost')
        .where('userId', isEqualTo: userId)
        .get()
        .then((querySnapshot) {
      communityPosts.value = querySnapshot.docs.map((doc) {
        return CommunityPost(
          userId: doc['userId'],
          question: doc['question'],
          description: doc['description'],
          imageUrl: doc['imageUrl'],
          postId: doc['postid'],
          username: doc['username'],
          userImage: doc['userImage'],
          likes: List<dynamic>.from(doc['likes']),
          dislikes: List<dynamic>.from(doc['dislikes']),
          answers: List<dynamic>.from(doc['answer']),
          timestamp: CustomFunction.formatDateTime(doc['timestamp'].toDate()),
        );
      }).toList();
      debugPrint("length of communitypost list is ${communityPosts.length}");
    }).catchError((error) {
      debugPrint('Error fetching community posts: $error');
    });
  }




Future<Map<String, dynamic>> toggleLike(
  String postId,
  bool isLike,
  bool isDislike,
  int likelen,
  int dislikelen,
) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final communityPostRef =
      FirebaseFirestore.instance.collection('CommunityPost').doc(postId);

  try {
    final docSnapshot = await communityPostRef.get();
    if (docSnapshot.exists) {
      List<dynamic> likes = docSnapshot.data()!['likes'] ?? [];
      List<dynamic> dislikes = docSnapshot.data()!['dislikes'] ?? [];

      if (likes.contains(userId)) {
        likes.remove(userId);
        isLike = false;
        likelen = likes.length;
      } else {
        likes.add(userId);
        likelen = likes.length;
        isLike = true;
        if (dislikes.contains(userId)) {
          dislikes.remove(userId);
          isDislike = false;
          dislikelen = dislikes.length;
        }
      }

      // Update the document with the modified likes and dislikes arrays
      await communityPostRef.update({'likes': likes, 'dislikes': dislikes});
    }

    // Return a map with updated values
    return {
      'like': isLike,
      'dislike': isDislike,
      'likelength': likelen,
      'dislikelength': dislikelen,
    };
  } catch (error) {
    debugPrint('Error toggling like: $error');
    // Handle the error and return an appropriate response
    return {
      'error': 'Error toggling like: $error',
    };
  }
}





Future<Map<String, dynamic>> toggleDislike(
  String postId,
  bool isLike,
  bool isDislike,
  int likelen,
  int dislikelen,
) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final communityPostRef =
      FirebaseFirestore.instance.collection('CommunityPost').doc(postId);

  try {
    final docSnapshot = await communityPostRef.get();
    if (docSnapshot.exists) {
      List<dynamic> dislikes = docSnapshot.data()!['dislikes'] ?? [];
      List<dynamic> likes = docSnapshot.data()!['likes'] ?? [];

      if (dislikes.contains(userId)) {
        dislikes.remove(userId);
        isDislike = false;
        dislikelen = dislikes.length;
      } else {
        dislikes.add(userId);
        dislikelen = dislikes.length;
        isDislike = true;
        if (likes.contains(userId)) {
          likes.remove(userId);
          isLike = false;
          likelen = likes.length;
        }
      }

      // Update the document with the modified likes and dislikes arrays
      await communityPostRef.update({'dislikes': dislikes, 'likes': likes});
    }

    // Return a map with updated values
    return {
      'like': isLike,
      'dislike': isDislike,
      'likeslen': likelen,
      'dislikelen': dislikelen,
    };
  } catch (error) {
    debugPrint('Error toggling dislike: $error');
    // Handle the error and return an appropriate response
    return {
      'error': 'Error toggling dislike: $error',
    };
  }
}


}
