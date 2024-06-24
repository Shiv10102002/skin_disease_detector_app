import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/service/userdata_controller.dart';
// import 'package:sihproject/view/Screen/home.dart';
// import 'package:sihproject/view/Screen/AuthScreen/login.dart';
// import 'package:sihproject/view/Widgets/profile_photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kritrima_tattva/constants/colors.dart';
import 'package:kritrima_tattva/service/userdata_controller.dart';
import 'package:kritrima_tattva/view/Screen/AuthScreen/login.dart';
import 'package:kritrima_tattva/view/Screen/home.dart';
import 'package:kritrima_tattva/view/Widgets/profile_photo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formfield = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  UserController userController = Get.put(UserController());
  bool passToggle = true;
  XFile? _profileImage;
  bool isobsecure = false;
  RxBool isloading = false.obs;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  Future<bool> _signup(
    String email,
    String pass,
    String name,
    String phone,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      String uid = userCredential.user!.uid;

      // Upload user image to Firebase Storage
      String imagePath = 'user_images/$uid.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(imagePath);
      UploadTask uploadimg = storageRef.putFile(File(_profileImage!.path));
      TaskSnapshot taskSnapshot = await uploadimg.whenComplete(() => null);
      String userimg = await taskSnapshot.ref.getDownloadURL();
      // Store additional user information in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'name': name,
        'number': phone,
        'email': email,
        // 'gender': _gender,
        'image': userimg,
      });
      return true;
      // Navigate to Home page or any other page after successful signup
      // userController.fetchUserData();
      // Get.to(() => const Home());
    } catch (e) {
      debugPrint(e.toString());
      return false;
      // Get.snackbar("signup failed", e.toString());
      // isloading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // actions: [],
          title: Text(
            "Kritrima Tattva",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.maincolor),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Form(
                    key: _formfield,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              _pickImage(ImageSource.gallery);
                            },
                            child: Stack(
                              children: [
                                ProfilePhoto(
                                  profileImage: _profileImage,
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: AppColor.maincolor,
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextField(
                          validator: (value) {
                            bool nameValid =
                                RegExp(r"^[a-zA-Z]").hasMatch(value!);

                            if (value.isEmpty) {
                              return 'Enter name';
                            } else if (!nameValid) {
                              return 'Enter valid name';
                            }
                            return null;
                          },
                          controller: nameController,
                          labelText: 'Name',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }

                            // Regular expression for validating email format
                            final RegExp emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              caseSensitive: false,
                            );

                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email';
                            }

                            return null;
                          },
                          controller: emailController,
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: phoneController,
                          labelText: 'phoneNo',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            }

                            // Regular expression for validating phone numbers (10 digits)
                            final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

                            if (!phoneRegex.hasMatch(value)) {
                              return 'Enter a valid phone number';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: passController,
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            } else if (passController.text.length < 6) {
                              return 'Password length should be more than 6 charecters';
                            }
                            return null;
                          },
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                                isobsecure = !isobsecure;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          obscureText: isobsecure,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Obx(
                          () => isloading.value == false
                              ? InkWell(
                                  onTap: () async {
                                    if (_formfield.currentState!.validate() &&
                                        _profileImage != null) {
                                      isloading.value = true;

                                      // print('Data added successfully');
                                      bool success = await _signup(
                                          emailController.text.toString(),
                                          passController.text.toString(),
                                          nameController.text.toString(),
                                          "+91${phoneController.text}");
                                      if (success == true) {
                                        //  Navigate to Home page or any other page after successful signup
                                        userController.fetchUserData();
                                        Get.to(() =>  Home());
                                      } else {
                                        Get.snackbar("signup failed",
                                            "Failed to create new account");
                                        isloading.value = false;
                                      }
                                      emailController.clear();
                                      passController.clear();
                                      phoneController.clear();
                                      nameController.clear();
                                    } else {
                                      Get.snackbar("Input data is empty",
                                          "Please fill all required data and profilepic");
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColor.maincolor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColor.maincolor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(() => const LogingScreen());
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: AppColor.maincolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool obscureText;

  const AppTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2, color: AppColor.maincolor),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppColor.maincolor),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
