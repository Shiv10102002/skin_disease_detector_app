// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sihproject/view/Screen/home.dart';
// import 'package:sihproject/view/Screen/login.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
//         useMaterial3: true,
//       ),
//       home: const AuthCheck(),
//       // home: const Home(),
//     );
//   }
// }

// class AuthCheck extends StatelessWidget {
//   const AuthCheck({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasData) {

//           return const Home();
//         } else {
//           return const LogingScreen();
//         }
//       },
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihproject/service/community_controller.dart';
import 'package:sihproject/service/network_controller.dart';
import 'package:sihproject/service/userdata_controller.dart';
import 'package:sihproject/view/Screen/home.dart';
import 'package:sihproject/view/Screen/AuthScreen/login.dart';
import 'package:sihproject/view/Screen/no_internet_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(NetworkController());
  Get.put(UserController());
  Get.put(CommunityController()); // Initialize the UserController
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Name',
        theme: ThemeData(
            // Your theme data
            ),
        home: const AuthCheck()
        // Navigate to AuthCheck screen
        );
  }
}

// class AuthCheck extends StatelessWidget {
//   const AuthCheck({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final UserController userController = Get.find<UserController>();

//     return Obx(() {
//       if (userController.user.name.isNotEmpty) {
//         // If user is logged in, navigate to Home screen
//         return const Home();
//       } else {
//         // If user is not logged in, navigate to LoginScreen
//         return const LogingScreen();
//       }
//     });
//   }
// }
// class AuthCheck extends StatelessWidget {
//   const AuthCheck({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final UserController userController = Get.find<UserController>();

//     final CommunityController communityController =
//         Get.find<CommunityController>();

//     return  StreamBuilder<User?>(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator();
//               } else if (snapshot.hasData) {
//                 // Reset user data to fetch new user details
//                 userController.fetchUserData();
//                 communityController.fetchCommunityPosts();

//                 return Home();
//               } else {
//                 return const LogingScreen();
//               }
//             },
//           )
//         ;
//   }
// }

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final NetworkController networkController = Get.find<NetworkController>();
    final CommunityController communityController =
        Get.find<CommunityController>();

    return GetX<NetworkController>(
      builder: (_) {
        if (!networkController.isConnected) {
          return const  NoInterNetScreen();
        }

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              userController.fetchUserData();
              communityController.fetchCommunityPosts();
              return Home();
            } else {
              return const LogingScreen();
            }
          },
        );
      },
    );
  }
}
