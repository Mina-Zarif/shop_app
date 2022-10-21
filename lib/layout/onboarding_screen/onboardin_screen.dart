import 'package:flutter/material.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/constants/Colors.dart';
import '../loginScreen/Shop_login_layout.dart';

// ignore: camel_case_types
class bulidModel {
  final String image;
  final String title;
  final String body;

  bulidModel(this.title, this.body, this.image);
}

bool isLast = false;
List<bulidModel> models = [
  bulidModel(
    'Looking for Items',
    'Our new service makes it easy for you to work anywhere, there are new features will really help you.',
    'assets/images/Ecommerce Onboarding Vector Illustration.jpg',
  ),
  bulidModel(
    'Make a Payment',
    'Our new service makes it easy for you to work anywhere, there are new features will really help you.',
    'assets/images/Ecommerce Onboarding Vector Illustration 2.jpg',
  ),
  bulidModel(
    'Send items',
    'Our new service makes it easy for you to work anywhere, there are new features will really help you.',
    'assets/images/Ecommerce Onboarding Vector Illustration 3.jpg',
  ),
];

// ignore: camel_case_types
class onBoarding_Screen extends StatefulWidget {
  const onBoarding_Screen({Key? key}) : super(key: key);

  @override
  State<onBoarding_Screen> createState() => _onBoarding_ScreenState();
}

// ignore: camel_case_types
class _onBoarding_ScreenState extends State<onBoarding_Screen> {
  @override
  Widget build(BuildContext context) {
    var boardController = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()async {
               await CacheHelper.SaveData(key: 'onBoarding', value: true)
                    .then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        )));
              },
              child: Text('SKIP'))
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    controller: boardController,
                    onPageChanged: (index) {
                      if (index == models.length - 1) {
                        setState(() {
                          isLast = true;
                          // print('islast');
                        });
                      } else {
                        setState(() {
                          isLast = false;
                          // print('is not last');
                        });
                      }
                    },
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => bultItem(index, context),
                    itemCount: models.length),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: models.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defultColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5),
                  ),
                  Spacer(),
                  FloatingActionButton(
                      onPressed: () {
                        if (isLast) {
                          CacheHelper.SaveData(key: 'onBoarding', value: true)
                              .then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  )));
                        } else {
                          boardController.nextPage(
                              duration: Duration(milliseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      child: (!isLast
                          ? Icon(Icons.arrow_forward_ios_outlined)
                          : Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Start'),
                            ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bultItem(index, context) => Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(models[index].image))),
          SizedBox(),
          Text(models[index].title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 40,
          ),
          Text(
            models[index].body,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ],
      ));
}
