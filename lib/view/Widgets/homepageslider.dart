import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sihproject/constants/colors.dart';

class HomepageSlider extends StatefulWidget {
  const HomepageSlider({super.key});

  @override
  State<HomepageSlider> createState() => _HomepageSliderState();
}

class _HomepageSliderState extends State<HomepageSlider> {
  var _currpagenum = 0.0;
  double scaleFactor = 0.8;
  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currpagenum = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 280,
          // color: AppColor.maincolor,
          child: PageView.builder(
            itemCount: 5,
            controller: pageController,
            itemBuilder: (context, index) {
              return _itemContainer(index, _currpagenum, scaleFactor);
            },
          ),
        ),
        //dot indicator section;
        DotsIndicator(
          dotsCount: 5,
          position: _currpagenum.toInt(),
          decorator: DotsDecorator(
            activeColor: AppColor.maincolor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _itemContainer(int index, var currpagenum, double scaleFactor) {
  double hight = 250;
  List<String>imgsrc = [
    "assets/headerimgone.jpeg",
    "assets/header_two_img.jpeg",
    "assets/headerimgone.jpeg",
    "assets/header_two_img.jpeg",
    "assets/headerimgone.jpeg",
    "assets/header_two_img.jpeg",
    "assets/headerimgone.jpeg",
    "assets/header_two_img.jpeg",
  ];
   List<String>imgdes = [
    "A Guide to the Kinds of Skin Diseases and How to Treat them",
    "Eczema: What It Is, Symptoms, Causes, Types & Treatment",
    "A Guide to the Kinds of Skin Diseases and How to Treat them",
    "Eczema: What It Is, Symptoms, Causes, Types & Treatment",
    "A Guide to the Kinds of Skin Diseases and How to Treat them",
    "Eczema: What It Is, Symptoms, Causes, Types & Treatment",
    "A Guide to the Kinds of Skin Diseases and How to Treat them",
    "Eczema: What It Is, Symptoms, Causes, Types & Treatment",
  ];

  Matrix4 matrix = Matrix4.identity();

  if (index == currpagenum.floor()) {
    var currScale = 1.0 - (currpagenum - index) * (1 - scaleFactor);
    var currTrans = hight * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else if (index == currpagenum.floor() + 1) {
    var currScale = scaleFactor + (currpagenum - index + 1) * (1 - scaleFactor);
    var currTrans = hight * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else if (index == currpagenum.floor() + 1) {
    var currScale = 1.0 - (currpagenum - index) * (1 - scaleFactor);
    var currTrans = hight * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else {
    var currScale = 0.8;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, hight * (1 - currScale) / 2, 0);
  }
  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image:  DecorationImage(
                    image: AssetImage(imgsrc[index]),
                    fit: BoxFit.fill)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            margin: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      offset: Offset(0, 5),
                      blurRadius: 5.0),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ]),
            child: Container(
              // height: 20,
              // color: Colors.black,
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Text(imgdes[index]),
            ),
          ),
        ),
      ],
    ),
  );
}
