// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';

// class Community {
//   static Future<bool> postquestion(
//     String ques,
//     String desc,
//     XFile? image,
//     String username,
//     String userImage,
//   ) async {
//     try {
//       // Get the current user's ID
//       String userId = FirebaseAuth.instance.currentUser!.uid;

//       // Reference to the CommunityPost collection
//       CollectionReference communityPosts =
//           FirebaseFirestore.instance.collection('CommunityPost');

//       // Generate a unique document ID
//       String postId = const Uuid().v4();

//       // If an image is provided, upload the image to Firebase Storage and get the download URL
//       String? imageUrl;
//       if (image != null) {
//         // Upload the image to Firebase Storage and get the download URL
//         imageUrl = await uploadImageToStorage(image, postId);
//       }

//       // Add data to the CommunityPost collection
//       await communityPosts.doc(postId).set({
//         'userId': userId,
//         'question': ques,
//         'description': desc,
//         'imageUrl': imageUrl, // URL of the uploaded image
//         'timestamp': DateTime.now(),
//         'postid': postId,
//         'userImage': userImage, // User's image URL
//         'username': username,
//         'likes': [],
//         'dislikes': [],
//         'answer': [],
//       });
//       return true;
//     } catch (error) {
//       debugPrint("Error adding community post: $error");
//       return false;
//       // Throw the error for handling in the UI
//     }
//   }

//   static Future<String?> uploadImageToStorage(
//       XFile image, String postId) async {
//     try {
//       // Reference to Firebase Storage
//       Reference storageRef =
//           FirebaseStorage.instance.ref().child('post_image/$postId.jpg');

//       // Upload the image file to the specified path
//       UploadTask uploadTask = storageRef.putFile(File(image.path));

//       // Get the download URL
//       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();

//       // Return the download URL
//       return downloadUrl;
//     } catch (error) {
//       debugPrint("Error uploading image: $error");
//       return null;
//       // Throw the error for handling in the UI
//     }
//   }
// }

// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:uuid/uuid.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


class Community {
  static Future<bool> postquestion(
    String ques,
    String desc,
    XFile? image,
    String username,
    String userImage,
  ) async {
    try {
      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Reference to the CommunityPost collection
      CollectionReference communityPosts =
          FirebaseFirestore.instance.collection('CommunityPost');

      // Generate a unique document ID
      String postId = const Uuid().v4();

      // If an image is provided, upload the image to Firebase Storage and get the download URL
      String? imageUrl;
      if (image != null) {
        // Compress and resize the image before uploading
        Uint8List compressedImage = await compressAndResizeImage(image);

        // Upload the compressed image to Firebase Storage and get the download URL
        imageUrl = await uploadImageToStorage(compressedImage, postId);
      }

      // Add data to the CommunityPost collection
      await communityPosts.doc(postId).set({
        'userId': userId,
        'question': ques,
        'description': desc,
        'imageUrl': imageUrl, // URL of the uploaded image
        'timestamp': DateTime.now(),
        'postid': postId,
        'userImage': userImage, // User's image URL
        'username': username,
        'likes': [],
        'dislikes': [],
        'answer': [],
      });
      return true;
    } catch (error) {
      debugPrint("Error adding community post: $error");
      return false;
      // Throw the error for handling in the UI
    }
  }

// Import this to use Uint8List

  static Future<Uint8List> compressAndResizeImage(XFile image) async {
    // Read the image file as bytes
    List<int> imageBytes = await image.readAsBytes();

    // Convert the List<int> to Uint8List
    Uint8List uint8ImageBytes = Uint8List.fromList(imageBytes);

    // Compress and resize the image
    List<int> compressedImageBytes =
        await FlutterImageCompress.compressWithList(
      uint8ImageBytes,
      minHeight: 800, // Adjust as needed
      minWidth: 800, // Adjust as needed
      quality: 85, // Adjust quality level
      format: CompressFormat.jpeg, // Output format
    );

    // Return the compressed and resized image bytes
    return Uint8List.fromList(compressedImageBytes);
  }

  static Future<String?> uploadImageToStorage(
      Uint8List image, String postId) async {
    try {
      // Reference to Firebase Storage
      Reference storageRef =
          FirebaseStorage.instance.ref().child('post_image/$postId.jpg');

      // Upload the image file to the specified path
      UploadTask uploadTask = storageRef.putData(image);

      // Get the download URL
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadUrl;
    } catch (error) {
      debugPrint("Error uploading image: $error");
      return null;
      // Throw the error for handling in the UI
    }
  }
}
