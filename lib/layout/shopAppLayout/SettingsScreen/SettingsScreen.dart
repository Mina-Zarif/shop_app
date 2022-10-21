import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppLayout/cubit/cubit.dart';
import 'package:shop_app/layout/shopAppLayout/cubit/states.dart';
import 'package:shop_app/shared/constants/Colors.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../../models/profileModel/profileModel.dart';
import '../../../shared/network/local/cacheHelper.dart';
import '../../loginScreen/Shop_login_layout.dart';
import '../HomeScreen/HomeScreen.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  // const SettingScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // ShopCubit.get(context).getProfileData();
        var model = ShopCubit.get(context).profileModel;
        return ConditionalBuilder(
            condition: model != null,
            builder: (context) => bulidProfileItems(context, model!),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget bulidProfileItems(context, ProfileModel model) {
    var cubit = ShopCubit.get(context);
    var FormKey = GlobalKey<FormState>();
    nameController.text = model.data!.name.toString();
    emailController.text = model.data!.email.toString();
    phoneController.text = model.data!.phone.toString();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: FormKey,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text('Name'),
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                  ),
                  enabled: cubit.modify,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Text('Email'),
                    prefixIcon: Icon(Icons.email),
                  ),
                  enabled: cubit.modify,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Text('Phone'),
                    prefixIcon: Icon(Icons.phone_android),
                  ),
                  enabled: cubit.modify,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: defultColor,
                  child: TextButton(
                    onPressed: () {
                      if (FormKey.currentState!.validate()) {
                        cubit.putUpdateProfile(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text);

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                        cubit.currentIndex = 0;
                        // ShopCubit.get(context).getProfileData();

                      }
                      // ShopCubit.get(context).getProfileData();

                      // cubit.currentIndex = 0;
                    },
                    child: Text(
                      'UPDATE PROFILE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: defultColor,
                  child: TextButton(
                    onPressed: () {
                      CacheHelper.sharedPreferences!.remove('token');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text(
                      'LOG OUT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
