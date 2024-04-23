// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sihproject/constants/colors.dart';
// import 'package:sihproject/view/Screen/aboutscreen.dart';
// import 'package:sihproject/view/Screen/community_screen.dart';
// import 'package:sihproject/view/Screen/homescreen.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int currentTab = 0;

//   final List<Widget> screens = [
//     const HomeScreen(),
//      CommunityScreen(),
//     const AboutScreen()
//   ];
//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = const HomeScreen();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomAppBar(
//         color: const Color.fromARGB(255, 238, 247, 246),
//         notchMargin: 4,
//         height: 60,
//         elevation: 5,
//         shape: const CircularNotchedRectangle(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: SizedBox(
//                 child: InkWell(
//                   // focusColor: AppColor.paracolor,
//                   // splashColor: AppColor.maincolor,
//                   borderRadius: BorderRadius.circular(20),
//                   onTap: () {
//                     setState(() {
//                       currentScreen = const HomeScreen();
//                       currentTab = 0;
//                     });
//                   },
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4)),
//                               child: Icon(
//                                 Icons.home,
//                                 color: currentTab == 0
//                                     ? AppColor.maincolor
//                                     : Colors.black,
//                               )),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: SizedBox(
//                             child: FittedBox(
//                               child: Text(
//                                 "Home",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: currentTab == 0
//                                       ? AppColor.maincolor
//                                       : Colors.black,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 textScaler: const TextScaler.linear(1),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 child: InkWell(
//                   // splashColor: AppColor.maincolor,
//                   borderRadius: BorderRadius.circular(20),
//                   onTap: () {
//                     setState(() {
//                       currentScreen =  CommunityScreen();
//                       currentTab = 1;
//                     });
//                   },
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: SizedBox(
//                               child: Icon(
//                             Icons.group,
//                             color: currentTab == 1
//                                 ? AppColor.maincolor
//                                 : Colors.black,
//                           )),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: SizedBox(
//                             child: FittedBox(
//                               child: Text(
//                                 "Community",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: currentTab == 1
//                                       ? AppColor.maincolor
//                                       : Colors.black,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 textScaler: const TextScaler.linear(1),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                 ),
//               ),
//             ),
//             //Right Tab Bar icon
//             Expanded(
//               child: SizedBox(
//                 child: InkWell(
//                   // splashColor: AppColor.maincolor,
//                   borderRadius: BorderRadius.circular(20),
//                   onTap: () {
//                     setState(() {
//                       currentTab = 2;
//                       currentScreen = const AboutScreen();
//                     });
//                   },
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: SizedBox(
//                             child: SvgPicture.asset(
//                               'assets/profile.svg',
//                               height: 20,
//                               width: 16,
//                               // ignore: deprecated_member_use
//                               color: currentTab == 2
//                                   ? AppColor.maincolor
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: SizedBox(
//                             child: FittedBox(
//                               child: Text(
//                                 "Profile",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: currentTab == 2
//                                       ? AppColor.maincolor
//                                       : Colors.black,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 textScaler: const TextScaler.linear(1),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: PageStorage(bucket: bucket, child: currentScreen),
//       backgroundColor: Colors.white,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sihproject/constants/colors.dart';
import 'package:sihproject/view/Screen/aboutscreen.dart';
import 'package:sihproject/view/Screen/community_screen.dart';
import 'package:sihproject/view/Screen/homescreen.dart';
import 'package:sihproject/view/Screen/mypost.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

   Home({super.key});
  // final CommunityController comcon = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   comcon.fetchCommunityPosts();
    // });
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 238, 247, 246),
        notchMargin: 4,
        height: 60,
        elevation: 5,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavBarItem(0, Icons.home, "Home"),
            buildNavBarItem(1, Icons.group, "Community"),
            buildNavBarItem(2, Icons.post_add, "MyPost"),
            buildNavBarItem(3, Icons.person, "Profile"),
          ],
        ),
      ),
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return const HomeScreen();
          case 1:
            return CommunityScreen();
          case 2:
            return const MyPostScreen();
          case 3:
            return const AboutScreen();
          default:
            return const SizedBox();
        }
      }),
      backgroundColor: Colors.white,
    );
  }

  Widget buildNavBarItem(int index, IconData icon, String label) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => controller.changePage(index),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                      child: Icon(
                    icon,
                    color: controller.currentIndex.value == index
                        ? AppColor.maincolor
                        : Colors.black,
                  )),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: FittedBox(
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: controller.currentIndex.value == index
                              ? AppColor.maincolor
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        textScaler: const TextScaler.linear(1),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
