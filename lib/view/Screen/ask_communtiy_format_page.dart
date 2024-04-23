import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sihproject/constants/colors.dart';
import 'package:sihproject/service/community_controller.dart';
import 'package:sihproject/service/community_service.dart';
import 'package:sihproject/service/post_controller.dart';
import 'package:sihproject/service/userdata_controller.dart';
import 'package:sihproject/view/Widgets/postdeseas.dart';

// ignore: must_be_immutable
class CommunityFormat extends StatelessWidget {
  CommunityFormat({super.key});

  final _askcommunity = GlobalKey<FormState>();

  TextEditingController questionController = TextEditingController();

  TextEditingController discController = TextEditingController();

  XFile? pickedimg;

  RxBool isloading = false.obs;

  @override
  Widget build(BuildContext context) {
    UserController usercontroller = Get.find<UserController>();
    CommunityController comcont = Get.find<CommunityController>();
    PostController postController = Get.find<PostController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ask Community",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _askcommunity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your question to the community ?",
                          style: TextStyle(
                              color: AppColor.maincolor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Descriptiontextfield(
                            discController: questionController,
                            helpertext:
                                "Add a question indicating whate's wrong with your skin"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Discription of your problem",
                          style: TextStyle(
                              color: AppColor.maincolor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Descriptiontextfield(
                          discController: discController,
                          helpertext: "Describe you skin problem in detail",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PostDeseas(
                    onImagePicked: (XFile? image) {
                      if (image != null) {
                        // Handle the picked image
                        pickedimg = image;
                        // debugPrint(
                        //     "picked image is " + pickedimg!.path.toString());
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => isloading.value == false
                        ? Fullwidthtextbutton(
                            onpress: () {
                              // Check form validation
                              isloading.value = true;
                              if (_askcommunity.currentState!.validate()) {
                                Community.postquestion(
                                  questionController.text.toString(),
                                  discController.text.toString(),
                                  pickedimg,
                                  usercontroller.user.name,
                                  usercontroller.user.userImg,
                                ).then((value) {
                                  if (value == true) {
                                    comcont.fetchCommunityPosts();
                                    postController.fetchCommunityPosts();
                                    Get.back();
                                  } else {
                                    Get.snackbar(
                                        "Post status", "Somthing wrong");
                                  }
                                });
                              }
                            },
                            text: "Post",
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.maincolor,
                              // Color.fromARGB(255, 19, 115, 125),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.8, 40),
                              maximumSize:
                                  Size(MediaQuery.of(context).size.width, 40),
                            ),
                            onPressed: () {},
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Descriptiontextfield extends StatelessWidget {
  const Descriptiontextfield({
    super.key,
    required this.discController,
    required this.helpertext,
  });

  final TextEditingController discController;
  final String helpertext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: TextFormField(
        // expands: true,
        maxLines: 10,
        maxLength: 400,
        keyboardType: TextInputType.multiline,
        controller: discController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: AppColor.maincolor)),
          focusColor: AppColor.maincolor,
          helperText: helpertext,
          helperStyle: const TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.maincolor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
        ),
        validator: (value) {
          bool quesValid = RegExp(r"^[a-zA-Z0-9]").hasMatch(value!);

          if (value.isEmpty) {
            return 'add description';
          } else if (!quesValid) {
            return 'Enter valid description';
          }
          return null;
        },
      ),
    );
  }
}

class Fullwidthtextbutton extends StatelessWidget {
  const Fullwidthtextbutton({
    super.key,
    required this.onpress,
    required this.text,
  });
  final Function onpress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.maincolor,
            // Color.fromARGB(255, 19, 115, 125),
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 40),
            maximumSize: Size(MediaQuery.of(context).size.width, 40),
          ),
          onPressed: () {
            onpress();
          },
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )),
    );
  }
}
