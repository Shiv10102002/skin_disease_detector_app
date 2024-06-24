import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kritrima_tattva/model/usermodel.dart';
// import 'package:sihproject/model/usermodel.dart';

class UserController extends GetxController {
  final _user = UserModel(
    name: '',
    userImg: '',
    email: '',
    phone: '',
  ).obs;

  UserModel get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }
  void resetUserData() {
    _user.value = UserModel(
      name: '',
      userImg: '',
      email: '',
      phone: '',
    );
  }
  void fetchUserData() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .get();

        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        _user.value = UserModel(
          name: userData['name'] ?? '',
          userImg: userData['image'] ?? '',
          email: userData['email'] ?? '',
          phone: userData['number'] ?? '',
        );
      } else {
        // Handle the case when the user is not logged in
        // For example, you can set default values or show a message
        _user.value = UserModel(
          name: 'Guest',
          userImg: '',
          email: '',
          phone: '',
        );
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }
}
