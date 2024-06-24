import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kritrima_tattva/service/answer_controller.dart';
import 'package:kritrima_tattva/view/Screen/ask_communtiy_format_page.dart';
// import 'package:sihproject/service/answer_controller.dart';
// import 'package:sihproject/view/Screen/ask_communtiy_format_page.dart';

class AnswerBottomSheet extends StatelessWidget {
  const AnswerBottomSheet({Key? key, required this.postid}) : super(key: key);
  final String postid;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Answer:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: Get.find<AnswerController>().answerController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your answer',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Link:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: Get.find<AnswerController>().linkController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter link (optional)',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Image:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 19, 115, 125),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 40),
                maximumSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
              ),
              onPressed: () {
                Get.find<AnswerController>().pickImage(ImageSource.camera);
              },
              child: const Text(
                "Take a picture",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Fullwidthtextbutton(
              onpress: () {
                Get.find<AnswerController>().submitAnswer(postid);
                Get.find<AnswerController>().fetchAnswers(postid);
                Get.back();
              },
              text: "Submit",
            )
          ],
        ),
      ),
    );
  }
}
