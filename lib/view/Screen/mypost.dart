import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kritrima_tattva/constants/colors.dart';
import 'package:kritrima_tattva/service/post_controller.dart';
import 'package:kritrima_tattva/view/Screen/ask_communtiy_format_page.dart';
import 'package:kritrima_tattva/view/Widgets/community_post.dart';
import 'package:kritrima_tattva/view/Widgets/drawer.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/service/post_controller.dart';
// import 'package:sihproject/view/Screen/ask_communtiy_format_page.dart';
// import 'package:sihproject/view/Widgets/community_post.dart';
// import 'package:sihproject/view/Widgets/drawer.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  PostController mypost = Get.put(PostController());
  @override
  void initState() {
    super.initState();
    mypost
        .fetchCommunityPosts(); // Fetch community posts when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Post",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
         floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.maincolor,
          isExtended: true,
          onPressed: () {
            Get.to(() =>  CommunityFormat());
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: const Text(
            "Ask Community",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        drawer: const CustomDrawer(),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: mypost.communityPosts
                  .map((post) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommunityPostwidget(post: post),
                      ))
                  .toList(),
            ),
          ),
        ));
  }
}
