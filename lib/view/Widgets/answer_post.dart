import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kritrima_tattva/constants/colors.dart';
import 'package:kritrima_tattva/service/answer_controller.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/service/answer_controller.dart';

class AnswerPost extends StatelessWidget {
  const AnswerPost(
      {super.key,
      required this.answer,
      required this.postid,
      required this.index});
  final Map<String, dynamic> answer;
  final String postid;
  final int index;

  @override
  Widget build(BuildContext context) {
    AnswerController answerController = Get.find<AnswerController>();
    String userid = FirebaseAuth.instance.currentUser!.uid;
    RxInt likelength = RxInt(answer['likes'].length);
    RxInt dislikelength = RxInt(answer['dislikes'].length);
    RxBool islike = answer['likes'].contains(userid) ? true.obs : false.obs;
    RxBool isdislike =
        answer['dislikes'].contains(userid) ? true.obs : false.obs;
    return Container(
      // margin:const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1,
              offset: const Offset(1, 1)),
          const BoxShadow(color: Colors.white, offset: Offset(0, 0)),
        ],
        // borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        backgroundColor: const Color.fromARGB(146, 2, 56, 39),
                        child: ClipOval(
                          child: Image(
                            image: NetworkImage(answer['userImage']),
                            height: 100,
                            width: 100,
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
                          answer['userName'],
                        ),
                        const Text(
                          "Time to post",
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
                  Text(answer['answer']),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "this kind of screen desease ",
                    style: TextStyle(
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
                          await answerController.toggleLike(postid, islike,
                              isdislike, likelength, dislikelength, index);
                      islike.value = res['like'].value;
                      isdislike.value = res['dislike'].value;
                      likelength.value = res['likeslength'].value;
                      dislikelength.value = res['dislikelength'].value;
                    },
                    icon: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            islike.value == false
                                ? const Icon(
                                    Icons.thumb_up_alt_outlined,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.thumb_up,
                                    color: AppColor.maincolor,
                                  ),
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
                            await answerController.toggledisLike(postid, islike,
                                isdislike, likelength, dislikelength, index);
                        islike.value = res['like'].value;
                        isdislike.value = res['dislike'].value;
                        likelength.value = res['likeslength'].value;
                        dislikelength.value = res['dislikelength'].value;
                      },
                      icon: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            isdislike.value
                                ? Icon(
                                    Icons.thumb_down_alt,
                                    color: AppColor.maincolor,
                                  )
                                : const Icon(
                                    Icons.thumb_down_alt_outlined,
                                    color: Colors.grey,
                                  ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              " ${dislikelength.value} DisLike",
                              style: const TextStyle(color: Colors.grey),
                              // textScaleFactor: 1,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
