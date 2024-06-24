import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kritrima_tattva/constants/colors.dart';
import 'package:kritrima_tattva/view/Screen/ask_communtiy_format_page.dart';
import 'package:kritrima_tattva/view/Screen/desease_found_screen.dart';

// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/view/Screen/ask_communtiy_format_page.dart';
// import 'package:sihproject/view/Screen/desease_found_screen.dart';

class SearchDeseas extends StatefulWidget {
  const SearchDeseas({super.key});

  @override
  State<SearchDeseas> createState() => _SearchDeseasState();
}

class _SearchDeseasState extends State<SearchDeseas> {
  File? pickedImage;
  // pickImage(ImageSource imageType) async {
  //   try {
  //     final photo = await ImagePicker()
  //         .pickImage(source: imageType, maxHeight: 300, maxWidth: 300);
  //     if (photo == null) {
  //       return;
  //     }

  //     final tempImage = File(photo.path);
  //     setState(() {
  //       pickedImage = tempImage;
  //     });
  //     debugPrint('data picked successfully');
  //     // await _fetchData(pickedImage!);
  //     Get.to(() => FoundDesease(
  //           pickedImage: pickedImage!,
  //         ));
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  // }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(
        source: imageType,
        
      );

      if (photo == null) {
        return;
      } else {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: photo.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: AppColor.maincolor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            // IOSUiSettings(
            //   title: 'Cropper',
            // ),
            // WebUiSettings(
            //   context: context,
            // ),
          ],
        );

        if (croppedFile == null) {
          return;
        }

        final tempImage = File(croppedFile.path);
        setState(() {
          pickedImage = tempImage;
        });

        // Proceed with your logic
        debugPrint('Image picked successfully');
        Get.to(() => FoundDesease(pickedImage: pickedImage!));
      }
    } catch (error) {
      debugPrint('the error during taking picture$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white54,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 185, 234, 241),
              offset: Offset(1, 1),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 185, 234, 241),
              offset: Offset(0, 0),
            )
          ]),
      child: Column(children: [
        Expanded(
            flex: 2,
            child: SizedBox(
              height: 74,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pickImage(ImageSource.camera);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 74,
                        // width: 156,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 1,
                                color:
                                    const Color.fromARGB(255, 79, 138, 144))),
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Icon(Icons.camera_alt,
                                  size: 18,
                                  color: Color.fromARGB(255, 79, 138, 144)),
                            ),
                            SizedBox(
                                // height: 20,
                                child: Text(
                              "Click a Photo",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 79, 138, 144),
                              ),
                              textScaler: TextScaler.linear(1),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 74,
                        // width: 156,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 79, 138, 144))),
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Icon(
                                Icons.image,
                                size: 18,
                                color: Color.fromARGB(255, 79, 138, 144),
                              ),
                            ),
                            // SizedBox(
                            //   height: 13,
                            // ),
                            SizedBox(
                                // height: 20,
                                child: Text(
                              "upload a photo",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 79, 138, 144),
                              ),
                              textScaler: TextScaler.linear(1),
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        Expanded(
            flex: 1,
            child: SizedBox(
              // color: Colors.greenAccent,
              child: Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 19, 115, 125),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.6, 40),
                      maximumSize:
                          Size(MediaQuery.of(context).size.width * 0.8, 40),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              contentPadding: const EdgeInsets.all(16),
                              backgroundColor: Colors.white,
                              alignment: Alignment.center,
                              title: Text(
                                "Select",
                                style: TextStyle(color: AppColor.maincolor),
                              ),
                              children: [
                                Fullwidthtextbutton(
                                  onpress: () {
                                    pickImage(ImageSource.camera);
                                    Get.back();
                                  },
                                  text: "Camera",
                                ),
                                Fullwidthtextbutton(
                                  onpress: () {
                                    pickImage(ImageSource.gallery);
                                    Get.back();
                                  },
                                  text: "Gallery",
                                ),
                                Fullwidthtextbutton(
                                  onpress: () {
                                    Get.back();
                                  },
                                  text: "Cancel",
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text(
                      "Take a picture",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ))
      ]),
    );
  }
}
