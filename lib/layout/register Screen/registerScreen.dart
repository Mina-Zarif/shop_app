import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/cacheHelper.dart';
import '../loginScreen/Shop_login_layout.dart';
import '../shopAppLayout/cubit/cubit.dart';
import '../shopAppLayout/shop_layout.dart';
import 'cubit/registerCubit.dart';
import 'cubit/registerStates.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopRegisterCubit.get(context);
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      listener: (context, state) {
        if (state is SuccessRegisterState) {
          if (state.RegisterModel!.status) {
            CacheHelper.SaveData(key: 'token', value: cubit.registerModel!.data!.token)
                .then((value) {
              token = state.RegisterModel!.data!.token!;
              navigateAndFinish(context, ShopLayout());
              ShopCubit.get(context).currentIndex = 0;
            });
            Fluttertoast.showToast(
              msg: state.RegisterModel!.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: chooseToastColor(ToastStates.SUCCESS),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            Fluttertoast.showToast(
              msg: state.RegisterModel!.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: chooseToastColor(ToastStates.ERROR),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      },
      builder: (context, state) => Scaffold(
        // backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Register'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline5),
                    Text(
                      'Register now to browse our hot offers',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.toString().isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-Mail Address',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.toString().isEmpty) {
                          return 'please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),

                        suffixIcon: IconButton(
                          onPressed: () {
                            // ShopLoginCubit.get(context).changeObscure();
                            cubit.changeObscure();
                          },
                          icon: (cubit.isShowen
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: cubit.isShowen,
                      validator: (value) {
                        if (value!.toString().isEmpty) {
                          return 'The Password is to short';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.toString().isEmpty) {
                          return 'please enter your Phone Number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                      condition: state is !LoadingRegisterState,
                      builder: (context) => Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              cubit.userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                              ShopCubit.get(context).getProfileData();
                            }
                          },
                          child: Text(
                            'Register'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('If You have an account?'),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text('Login'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
