import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kritrima_tattva/constants/colors.dart';
import 'package:kritrima_tattva/service/userdata_controller.dart';
import 'package:kritrima_tattva/view/Screen/AuthScreen/login.dart';
import 'package:kritrima_tattva/view/Screen/mypost.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/service/userdata_controller.dart';
// import 'package:sihproject/view/Screen/AuthScreen/login.dart';
// import 'package:sihproject/view/Screen/mypost.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final UserController usercontroller = Get.put(UserController());

    return Drawer(
      backgroundColor: AppColor.maincolor,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                      child: Image.network(
                    usercontroller.user.userImg,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  )),
                ),
              ),
              Text(
                "Name : ${usercontroller.user.name}",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "Email : ${usercontroller.user.email}",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "Phone : ${usercontroller.user.phone}",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
          const Divider(
            color: Colors.white,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Get.to(() => const MyPostScreen());
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.pages_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "My Post",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      // Log out the user
                      FirebaseAuth.instance.signOut();
                      Get.find<UserController>().resetUserData();
                      // Navigate to the LoginScreen
                      Get.offAll(() => const LogingScreen());
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
