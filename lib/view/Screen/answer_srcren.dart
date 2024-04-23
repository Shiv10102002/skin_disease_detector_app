import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihproject/constants/colors.dart';
import 'package:sihproject/service/answer_controller.dart';
import 'package:sihproject/view/Screen/ask_communtiy_format_page.dart';
import 'package:sihproject/view/Widgets/answer_bottom_sheet.dart';
import 'package:sihproject/view/Widgets/answer_post.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({
    super.key,
    required this.desc,
    required this.postimg,
    required this.ques,
    required this.postid,
  });
  final String ques;
  final String desc;
  final String postimg;
  final String postid;

  @override
  Widget build(BuildContext context) {
    final AnswerController answerController = Get.find<AnswerController>();

    // Fetch answers when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      answerController.fetchAnswers(postid);
    });
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 40,
        child: Fullwidthtextbutton(
          onpress: () {
            Get.lazyPut(() => AnswerController());

            _showBottomSheet(context, postid);
          },
          text: "write you answer",
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 231, 228, 228),
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              leadingWidth: 40,
              // title: Text("ques"),
              backgroundColor: Colors.white,

              expandedHeight: 220,
              floating: true,
              pinned: true,
              collapsedHeight: 220,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 0, left: 50),
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              image: DecorationImage(
                                  image: NetworkImage(postimg),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          left: 20,
                          top: 20,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: AppColor.maincolor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      // color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              ques,
                              style: TextStyle(
                                  color: AppColor.maincolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            // const SizedBox(
                            //   height: 4,
                            // ),
                            Text(
                              desc,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              sliver: Obx(
                () {
                  if (answerController.answers.isEmpty) {
                    // Show loading indicator while fetching data
                    return const SliverToBoxAdapter(
                      child: Center(child: Text("NO Response From Community")),
                    );
                  } else {
                    // Build the list of AnswerPost widgets
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          debugPrint(
                              answerController.answers[index].toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: AnswerPost(
                              index: index,
                                postid: postid,
                                answer: answerController.answers[index]
                                    as Map<String, dynamic>),
                          );
                        },
                        childCount: answerController.answers.length,
                      ),
                    );
                  }
                },
              ),
            ),
            // SliverList(
            //     delegate: SliverChildBuilderDelegate(childCount: 5,
            //         (context, intdex) {
            //   return const Padding(
            //       padding: EdgeInsets.only(top: 10, left: 16, right: 16),
            //       child: AnswerPost());
            // })),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String postid) {
    Get.bottomSheet(
      AnswerBottomSheet(
        postid: postid,
      ),
    );
  }
}
