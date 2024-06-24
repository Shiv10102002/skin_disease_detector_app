// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/service/date_format.dart';
// import 'package:sihproject/view/Screen/ask_communtiy_format_page.dart';
// import 'package:sihproject/view/Widgets/community_post.dart';
// import 'package:sihproject/view/Widgets/drawer.dart';

// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({super.key});

//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // backgroundColor: const Color.fromRGBO(255, 255, 255, 0.5),
//         appBar: AppBar(
//           title: const Text(
//             "Community",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//         ),
//         drawer: const CustomDrawer(),
//         floatingActionButton: FloatingActionButton.extended(
//           backgroundColor: AppColor.maincolor,
//           isExtended: true,
//           onPressed: () {
//             Get.to(() => const CommunityFormat());
//           },
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           icon: const Icon(
//             Icons.edit,
//             color: Colors.white,
//           ),
//           label: const Text(
//             "Ask Community",
//             style: TextStyle(
//                 fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
//             // textScaleFactor: 1,
//           ),
//         ),
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('CommunityPost')
//               .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             // Extract the list of documents from the snapshot
//             List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//             return ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: documents.length,
//               itemBuilder: (context, index) {
//                 var data = documents[index].data() as Map<String, dynamic>;
//                 String ques = data['question'];
//                 String desc = data['description'];
//                 String imgUrl = data['imageUrl'];
//                 String postid = data['postid'];
//                 String username = data['username'];
//                 String userImg = data['userImage'];
//                 String timestamp =
//                     CustomFunction.formatDateTime(data['timestamp'].toDate());
//                 debugPrint(
//                     "timestamp is $timestamp and username is $username and userimg is $userImg");
//                 return Padding(
//                   padding: const EdgeInsets.only(
//                     top: 16,
//                   ),
//                   child: CommunityPost(
//                     desc: desc,
//                     ques: ques,
//                     img: imgUrl,
//                     time: timestamp,
//                     userimg: userImg,
//                     username: username,
//                     postid: postid,
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kritrima_tattva/constants/colors.dart';
import 'package:kritrima_tattva/model/community_post_model.dart';
import 'package:kritrima_tattva/service/community_controller.dart';
import 'package:kritrima_tattva/service/post_controller.dart';
import 'package:kritrima_tattva/view/Screen/ask_communtiy_format_page.dart';
import 'package:kritrima_tattva/view/Widgets/community_post.dart';
import 'package:kritrima_tattva/view/Widgets/drawer.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/model/community_post_model.dart';
// import 'package:sihproject/service/community_controller.dart';
// import 'package:sihproject/service/post_controller.dart';
// import 'package:sihproject/view/Widgets/community_post.dart';

// import 'package:sihproject/view/Widgets/drawer.dart';
// import 'package:sihproject/view/Screen/ask_communtiy_format_page.dart';

class CommunityScreen extends StatelessWidget {
  final CommunityController communityController =
      Get.find<CommunityController>();

  CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Community",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        drawer: const CustomDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.maincolor,
          isExtended: true,
          onPressed: () {
            Get.lazyPut(() => PostController());
            Get.to(() => CommunityFormat());
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
        body: Obx(() {
          if (communityController.uploading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (communityController.communityPosts.isEmpty) {
            return const Center(
              child: Text("No Post Available"),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: communityController.communityPosts.length,
              itemBuilder: (context, index) {
                final CommunityPost post =
                    communityController.communityPosts[index];
                return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: CommunityPostwidget(post: post));
              },
            );
          }
        }),
      ),
    );
  }
}
