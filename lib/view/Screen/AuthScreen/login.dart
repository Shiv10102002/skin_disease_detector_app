import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihproject/constants/colors.dart';
import 'package:sihproject/service/userdata_controller.dart';
import 'package:sihproject/view/Screen/AuthScreen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sihproject/view/Screen/home.dart';

class LogingScreen extends StatefulWidget {
  const LogingScreen({super.key});

  @override
  State<LogingScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LogingScreen> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    RxBool isloading = false.obs;

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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          // height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      width: 2, color: AppColor.maincolor)),
                              labelText: 'Email',
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              prefixIcon: const Icon(Icons.email),
                            ),
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
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          // height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: passController,
                            obscureText: passToggle,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      width: 2, color: AppColor.maincolor)),
                              labelText: 'PassWord',
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Icon(passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else if (passController.text.length < 6) {
                                return 'Password length should be more than 6 charecters';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Obx(
                          () => isloading.value == false
                              ? InkWell(
                                  onTap: () async {
                                    if (_formfield.currentState!.validate()) {
                                      // print('Data added successfully');
                                      isloading.value = true;

                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                          email: emailController.text.trim(),
                                          password: passController.text.trim(),
                                        );
                                        userController.fetchUserData();
                                        Get.to(() =>  Home());
                                      } catch (e) {
                                        debugPrint(e.toString());
                                        isloading.value = false;
                                        Get.snackbar(
                                            "Login Failed", e.toString());
                                      }
                                      emailController.clear();
                                      passController.clear();
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
                                        'Log In',
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
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(() => const SignupScreen());
                                  },
                                  child: Text(
                                    'Sign Up',
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
