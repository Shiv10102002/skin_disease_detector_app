import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sihproject/service/userdata_controller.dart';

class AnswerController extends GetxController {
  TextEditingController answerController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  RxList<dynamic> answers = <dynamic>[].obs;

  void fetchAnswers(String postId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('CommunityPost')
          .doc(postId)
          .get();

      // Explicitly cast the result to Map<String, dynamic>
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      // Use null-aware operator (?.) to safely access the data
      List<dynamic>? fetchedAnswers = data?['answer'];
      // Check if fetchedAnswers is not null before assigning
      if (fetchedAnswers != null) {
        answers.assignAll(fetchedAnswers);
      }
    } catch (error) {
      debugPrint('Error fetching answers: $error');
    }
  }

  void submitAnswer(String postId) {
    String answer = answerController.text;
    String link = linkController.text;
    String image = imageController.text;

    // Retrieve user data from UserController
    UserController userController = Get.find<UserController>();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String userName = userController.user.name;
    String userImage = userController.user.userImg;

    // Prepare answer data
    Map<String, dynamic> answerData = {
      'likes': [],
      'dislikes': [],
      'timestamp': DateTime.now(),
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'answer': answer,
      'link': link.isEmpty ? null : link,
      'image': image.isNotEmpty ? image : null,
    };

    // Update document in CommunityPost collection
    try {
      FirebaseFirestore.instance
          .collection('CommunityPost')
          .doc(postId)
          .update({
        'answer': FieldValue.arrayUnion([answerData]),
      });
      // Clear text field values after submission
      answerController.clear();
      linkController.clear();
      imageController.clear();
      debugPrint('Answer submitted successfully!');
    } catch (error) {
      debugPrint('Error submitting answer: $error');
    }
  }

  void pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      Get.find<AnswerController>().imageController.text = tempImage.path;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<Map<String, dynamic>> toggleLike(
    String postId,
    RxBool isLike,
    RxBool isDislike,
    RxInt likeslength,
    RxInt dislikelength,
    int index,
  ) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final communityPostRef =
        FirebaseFirestore.instance.collection('CommunityPost').doc(postId);

    try {
      DocumentSnapshot docSnapshot = await communityPostRef.get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>; // Explicit casting
        List<Map<String, dynamic>> answer =
            List<Map<String, dynamic>>.from(data['answer']);

        // Check if the userId is already in the likes array
        List<dynamic> likes = answer[index]['likes'] ?? [];
        List<dynamic> dislikes = answer[index]['dislikes'] ?? [];

        if (likes.contains(userId)) {
          // If userId is already in likes, remove userId from likes array
          likes.remove(userId);
          isLike.value = false;
          likeslength.value = likes.length;
        } else {
          // If userId is not in likes, add userId to likes array
          likes.add(userId);
          isLike.value = true;
          likeslength.value = likes.length;
          if (dislikes.contains(userId)) {
            dislikes.remove(userId);
            isDislike.value = false;
            dislikelength.value = dislikes.length;
          }
        }

        // Update likes and dislikes arrays in the answer list
        answer[index]['likes'] = likes;
        answer[index]['dislikes'] = dislikes;

        // Update the likes and dislikes arrays in the document
        await communityPostRef.update({'answer': answer});

        return {
          'like': isLike,
          'dislike': isDislike,
          'likeslength': likeslength,
          'dislikelength': dislikelength,
        };
      } else {
        throw 'Document does not exist';
      }
    } catch (error) {
      debugPrint('Error toggling like: $error');
      return {};
    }
  }

  Future<Map<String, dynamic>> toggledisLike(
    String postId,
    RxBool isLike,
    RxBool isDislike,
    RxInt likeslength,
    RxInt dislikelength,
    int index,
  ) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final communityPostRef =
        FirebaseFirestore.instance.collection('CommunityPost').doc(postId);

    try {
      DocumentSnapshot docSnapshot = await communityPostRef.get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>; // Explicit casting
        List<Map<String, dynamic>> answer =
            List<Map<String, dynamic>>.from(data['answer']);

        // Check if the userId is already in the likes array
        List<dynamic> likes = answer[index]['likes'] ?? [];
        List<dynamic> dislikes = answer[index]['dislikes'] ?? [];

        if (dislikes.contains(userId)) {
          // If userId is already in likes, remove userId from likes array
          dislikes.remove(userId);
          isDislike.value = false;
          dislikelength.value = dislikes.length;
        } else {
          // If userId is not in likes, add userId to likes array
          dislikes.add(userId);
          isDislike.value = true;
          dislikelength.value = dislikes.length;
          if (likes.contains(userId)) {
            likes.remove(userId);
            isLike.value = false;
            likeslength.value = likes.length;
          }
        }

        // Update likes and dislikes arrays in the answer list
        answer[index]['likes'] = likes;
        answer[index]['dislikes'] = dislikes;

        // Update the likes and dislikes arrays in the document
        await communityPostRef.update({'answer': answer});

        return {
          'like': isLike,
          'dislike': isDislike,
          'likeslength': likeslength,
          'dislikelength': dislikelength,
        };
      } else {
        throw 'Document does not exist';
      }
    } catch (error) {
      debugPrint('Error toggling dislike: $error');
      return {};
    }
  }
}
