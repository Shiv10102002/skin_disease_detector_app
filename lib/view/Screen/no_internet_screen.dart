import 'package:flutter/material.dart';
import 'package:sihproject/constants/colors.dart';

class NoInterNetScreen extends StatelessWidget {
  const NoInterNetScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Center(child: Card(
        color: AppColor.maincolor,
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.4,horizontal: 16),
        child: Padding(
          padding:const EdgeInsets.all(12),
          child: Center(child: Text('No Enternet Connection \n Please Provide Internet Connection',style: TextStyle(color: AppColor.textcolor,fontSize: 14),textAlign: TextAlign.center,)),
        ),
      ),),
    );
  }
}