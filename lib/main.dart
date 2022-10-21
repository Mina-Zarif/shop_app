import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/loginScreen/Shop_login_layout.dart';
import 'package:shop_app/layout/shopAppLayout/searchScreen/cubit/cubit.dart';
import 'package:shop_app/layout/shopAppLayout/shop_layout.dart';
import 'package:shop_app/shared/constants/Colors.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/BlocObserver.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

import 'layout/loginScreen/cubit/cubit.dart';
import 'layout/onboarding_screen/onboardin_screen.dart';
import 'layout/register Screen/cubit/registerCubit.dart';
import 'layout/shopAppLayout/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget;
  bool onBoarding = (CacheHelper.getBoolen(key: 'onBoarding') ?? false);
  token = CacheHelper.getString(key: 'token');
  print(token);
  // print(onBoarding);
  if (onBoarding == true) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = onBoarding_Screen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoriteData()
            ..getProfileData(),
        ),
        BlocProvider(
          create: (context) => ShopRegisterCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: defultColor,
          // backgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: defultColor,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: TextStyle(color: defultColor),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              showUnselectedLabels: true),
          fontFamily: 'jannah',
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
              // titleTextStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
              // actionsIconTheme: IconThemeData(color: Colors.black),
              systemOverlayStyle: SystemUiOverlayStyle(
                // statusBarColor: Colors.white,
                // statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
              )),
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
