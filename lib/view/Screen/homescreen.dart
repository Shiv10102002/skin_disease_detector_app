import 'package:flutter/material.dart';
import 'package:sihproject/constants/colors.dart';
import 'package:sihproject/view/Widgets/drawer.dart';
import 'package:sihproject/view/Widgets/homepageslider.dart';
import 'package:sihproject/view/Widgets/search_deseas.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const  Text(
            "Home",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        drawer: const CustomDrawer(),
        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const HomepageSlider(),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Search Desease",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColor.mainBlackColor),),
            ),
            const SearchDeseas()
          ]),
        ),
      ),
    );
  }
}
