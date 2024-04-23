import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihproject/constants/colors.dart';
import 'package:sihproject/model/community_post_model.dart';
import 'package:sihproject/service/answer_controller.dart';
import 'package:sihproject/service/community_controller.dart';
import 'package:sihproject/service/post_controller.dart';
import 'package:sihproject/view/Screen/answer_srcren.dart';
// import 'package:sihproject/constants/colors.dart';

class CommunityPostwidget extends StatelessWidget {
  const CommunityPostwidget({
    super.key,
    required this.post,
  });

  final CommunityPost post;

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.put(PostController());

    String userid = FirebaseAuth.instance.currentUser!.uid;
    RxInt likelength = RxInt(post.likes.length);
    RxInt dislikelength = RxInt(post.dislikes.length);
    RxBool islike = post.likes.contains(userid) ? true.obs : false.obs;
    RxBool isdislike = post.dislikes.contains(userid) ? true.obs : false.obs;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(214, 232, 239, 0.698),
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Color.fromRGBO(214, 232, 239, 0.698),
            offset: Offset(1, -1),
          ),
          BoxShadow(
            color: Color.fromRGBO(214, 232, 239, 0.698),
            offset: Offset(-1, 0),
          ),
          BoxShadow(
            color: Color.fromRGBO(214, 232, 239, 0.698),
            offset: Offset(0, -1),
          ),
          BoxShadow(color: Colors.white, offset: Offset(0, 0)),
          // BoxShadow(color: Colors.white, offset: Offset(1, 0)),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: Colors.blueGrey,
                image: DecorationImage(
                    image: NetworkImage(post.imageUrl), fit: BoxFit.cover)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.lightGreen,

                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                        child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(146, 2, 56, 39),
                            child: ClipOval(
                              child: post.userImage.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.white,
                                    )
                                  : Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(post.userImage),
                                      fit: BoxFit.cover,
                                    ),
                            )),
                      ),
                      // SizedBox(
                      //   width: 12,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.username,
                            ),
                            Text(
                              post.timestamp,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  // color: Colors.grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${post.question} ?"),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        post.description,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                //  const SizedBox(
                //     height: 8,
                //   ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.lazyPut(() => AnswerController());
                            Get.to(() => AnswerScreen(
                                  desc: post.description,
                                  ques: post.question,
                                  postimg: post.imageUrl,
                                  postid: post.postId,
                                ));
                          },
                          child: Text(
                            "answers",
                            style: TextStyle(color: AppColor.maincolor),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic> res =
                              await postController.toggleLike(
                                  post.postId,
                                  islike.value,
                                  isdislike.value,
                                  likelength.value,
                                  dislikelength.value);

                          islike.value = res['like'];
                          isdislike.value = res['dislike'];
                          likelength.value = res['likelength'];
                          dislikelength.value = res['dislikelength'];
                          Get.find<CommunityController>().fetchCommunityPosts();
                        },
                        icon: Obx(() => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                    islike.value == false
                                        ? Icons.thumb_up_alt_outlined
                                        : Icons.thumb_up,
                                    color: islike.value == false
                                        ? Colors.grey
                                        : AppColor.maincolor),
                                const SizedBox(width: 4),
                                Text(
                                  "${likelength.value} Like",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            )),
                      ),
                      IconButton(
                          onPressed: () async {
                            Map<String, dynamic> res =
                                await postController.toggleDislike(
                                    post.postId,
                                    islike.value,
                                    isdislike.value,
                                    likelength.value,
                                    dislikelength.value);

                            islike.value = res['like'];
                            isdislike.value = res['dislike'];
                            likelength.value = res['likeslen'];
                            dislikelength.value = res['dislikelen'];
                            Get.find<CommunityController>()
                                .fetchCommunityPosts();
                          },
                          icon: Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                isdislike.value == false
                                    ? const Icon(
                                        Icons.thumb_down_alt_outlined,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.thumb_down,
                                        color: AppColor.maincolor,
                                      ),
                                const SizedBox(width: 4),
                                Text(
                                  "${dislikelength.value} Dislike",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
