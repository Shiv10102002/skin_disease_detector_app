

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kritrima_tattva/constants/colors.dart';
import 'package:kritrima_tattva/service/found_disease_controller.dart';
import 'package:kritrima_tattva/service/post_controller.dart';
import 'package:kritrima_tattva/view/Screen/ask_communtiy_format_page.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/service/found_disease_controller.dart';
// import 'package:sihproject/view/Screen/ask_communtiy_format_page.dart';

class FoundDesease extends StatelessWidget {
  final File pickedImage;

  FoundDesease({Key? key, required this.pickedImage}) : super(key: key);

  final FoundDiseaseController _controller = Get.find<FoundDiseaseController>();
  
  // final FoundDiseaseController _controller = Get.put(FoundDiseaseController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchData(pickedImage);
    });
    return SafeArea(
      child: Scaffold(
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
            // textScaleFactor: 1,
          ),
        ),
        body: Obx(() {
          return _controller.uploading.value
              ?const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      leading: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.keyboard_arrow_left)),
                      expandedHeight: 200,
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: SizedBox(
                            height: 200,
                            child: Image.file(
                              pickedImage,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About Disease",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.maincolor),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                                "* Disease Name: ${_controller.resData['disease']}"),
                            const SizedBox(
                              height: 12,
                            ),
                            Text("${_controller.resData['overview']}"),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Symptoms",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.maincolor),
                              textAlign: TextAlign.left,
                            ),
                            ...(_controller.resData['symptoms']
                                    as List<dynamic>)
                                .map((e) => Text("-> $e ."))
                                .toList(),
                            Text(
                              "Causes",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.maincolor),
                              textAlign: TextAlign.left,
                            ),
                            ...(_controller.resData['causes'] as List<dynamic>)
                                .map((e) => Text("-> $e ."))
                                .toList(),
                            Text(
                              "Treatments",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.maincolor),
                              textAlign: TextAlign.left,
                            ),
                            ...(_controller.resData['treatments']
                                    as List<dynamic>)
                                .map((e) => Text('-> $e .'))
                          ],
                        ),
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }
}
