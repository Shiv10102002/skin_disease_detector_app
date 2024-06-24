import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kritrima_tattva/constants/colors.dart';
import 'package:kritrima_tattva/service/userdata_controller.dart';
import 'package:kritrima_tattva/view/Widgets/drawer.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/service/userdata_controller.dart';
// import 'package:sihproject/view/Widgets/drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return Scaffold(
        appBar: AppBar(
            title: const Text("Kritrima Tattva",
                style: TextStyle(
                    // color: AppColor.maincolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600))),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Obx(
              () => Container(
                // color: Colors.blue,
                height: 130,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.paracolor,
                          borderRadius: BorderRadius.circular(8),
                          // image: DecorationImage(
                          //   image: NetworkImage(userController.user.userImg),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: userController.user.userImg,
                            fit: BoxFit.cover,
                            // width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      flex: 5,
                      child: SizedBox(
                        // color: Colors.amber,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  userController.user.email,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 19, 11, 11),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  userController.user.name,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 19, 11, 11),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.maincolor,
                                      // Color.fromARGB(255, 19, 115, 125),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.6,
                                          40),
                                      maximumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                          40),
                                    ),
                                    onPressed: () {
                                      // Get.to(const LogingScreen());
                                    },
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )),
                              )
                            ]),
                      ))
                ]),
              ),
            )
          ],
        ));
  }
}
