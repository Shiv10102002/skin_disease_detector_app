import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kritrima_tattva/constants/colors.dart';
// import 'package:sihproject/constants/colors.dart';

class PostDeseas extends StatefulWidget {
  const PostDeseas({super.key, required this.onImagePicked});
  final Function(XFile?) onImagePicked;

  @override
  State<PostDeseas> createState() => _PostDeseasState();
}

class _PostDeseasState extends State<PostDeseas> {
  XFile? pickedImage;
  // pickImage(ImageSource imageType) async {
  //   try {
  //     final photo = await ImagePicker().pickImage(source: imageType);
  //     if (photo == null) return;
  //     final tempImage = XFile(photo.path);
  //     setState(() {
  //       pickedImage = tempImage;
  //     });
  //     widget.onImagePicked(pickedImage);
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  // }
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      setState(() {
        pickedImage = XFile(photo.path); // Change this line
      });
      widget.onImagePicked(photo); // Change this line
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add an image to your post",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.maincolor),
        ),
      
        Container(
          height: 100,
          width: 100,
          color: Colors.black12,
          child: pickedImage != null
              ? Image.file(
                  File(pickedImage!.path), // Convert XFile to File here
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Icon(
                    Icons.image,
                    color: Colors.grey,
                  ),
                ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
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
                            child: const GetPicFromUserButton(
                                icon: Icon(Icons.camera_alt,
                                    size: 18,
                                    color: Color.fromARGB(255, 79, 138, 144)),
                                text: "Click a Photo")),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: const GetPicFromUserButton(
                            icon: Icon(
                              Icons.image,
                              size: 18,
                              color: Color.fromARGB(255, 79, 138, 144),
                            ),
                            text: "Take from Gallery",
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
                          backgroundColor:
                              const Color.fromARGB(255, 19, 115, 125),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.6, 40),
                          maximumSize:
                              Size(MediaQuery.of(context).size.width * 0.8, 40),
                        ),
                        onPressed: () {
                          showdialog(context);
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
        ),
      ],
    );
  }

  Future<dynamic> showdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: AppColor.maincolor,
            alignment: Alignment.center,
            title: const Text(
              "Select",
              style: TextStyle(color: Colors.white),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MaterialButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                      Get.back();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Camera",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.maincolor),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MaterialButton(
                    color: Colors.white,
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.maincolor),
                    )),
              ),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))
            ],
          );
        });
  }
}

class GetPicFromUserButton extends StatelessWidget {
  const GetPicFromUserButton(
      {super.key, required this.icon, required this.text});
  final Icon icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 74,
      // width: 156,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromARGB(255, 79, 138, 144))),
      child: Column(
        children: [
          SizedBox(height: 24, width: 24, child: icon),
          SizedBox(
              child: Text(
            text,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 79, 138, 144),
                overflow: TextOverflow.ellipsis),
            textScaler: const TextScaler.linear(1),
          ))
        ],
      ),
    );
  }
}
