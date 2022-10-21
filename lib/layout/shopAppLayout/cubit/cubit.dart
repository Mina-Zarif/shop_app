import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppLayout/SettingsScreen/SettingsScreen.dart';
import 'package:shop_app/layout/shopAppLayout/cubit/states.dart';
import 'package:shop_app/models/HomeModel/Home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import '../../../models/FavouriteModel/FavouriteModel.dart';
import '../../../models/categoriesModel/categoriesModel.dart';
import '../../../models/profileModel/profileModel.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/network/local/cacheHelper.dart';
import '../../../shared/network/local/endPoint.dart';
import '../../loginScreen/Shop_login_layout.dart';
import '../CategoriesScreen/CategoriesSCreen.dart';
import '../FavouriteScreen/FavouriteScreen.dart';
import '../HomeScreen/HomeScreen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopAppInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool modify = true;
  int currentIndex = 0;
  List<Widget> screens = [
    // ShopLayout(),
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  void changeIndex(ind) {
    currentIndex = ind;
    emit(ShopAppChangeIndexState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopAppLoadingGetData());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(value);
    }).then((value) {
      // print(value.toString());
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      // print(favorites);
      emit(ShopHomeAppSeccessGetData());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeAppErrorGetData());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(value);
    }).then((value) {
      // print('data is Gotten : ${value.toString()}');
      emit(ShopCategoriesAppSeccessGetData());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesAppErrorGetData());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(int id) {
    emit(ShopFavoritesAppLoadingGetData());
    favorites[id] = !favorites[id]!;
    emit(ShopChangeFavoritesAppGetData());
    DioHelper.postData(url: FAVOURITE, data: {"product_id": id}, token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status!) {
        favorites[id] = !favorites[id]!;
        emit(ShopChangeFavoritesAppErrorGetData());
      } else {
        getFavoriteData();
      }
      emit(ShopChangeFavoritesAppSeccessGetData(changeFavoriteModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopChangeFavoritesAppErrorGetData());
    });
  }

  GetFavoriteModel? favoriteModel;

  void getFavoriteData() {
    emit(ShopAppLoadingGetData());
    DioHelper.getData(url: FAVOURITE, token: token).then((value) {
      favoriteModel = GetFavoriteModel.fromJson(value.data);
      // print(value);
    }).then((value) {
      // print('data is Gotten : ${value.toString()}');
      emit(ShopFavoritesAppSeccessGetData());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavoritesAppErrorGetData());
    });
  }

  ProfileModel? profileModel;
  void getProfileData() {
    emit(ShopProfileAppLoadingGetData());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      // print (value.data);
      emit(ShopProfileAppSeccessGetData());
    }).catchError((error) {
      print('error in profile ${error.toString()}');
      emit(ShopFavoritesAppErrorGetData());
    });
  }

  // void signOut(context)
  // {
  //   CacheHelper.sharedPreferences!.remove('token');
  //   Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen(),));
  // }
  ProfileModel? registerModel;

  void getRegisterData() {
    emit(ShopRegisterAppLoadingGetData());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      registerModel = ProfileModel.fromJson(value.data!);
      // print (value.data);
      emit(ShopRegisterAppSeccessGetData());
    }).catchError((error) {
      print('error in profile ${error.toString()}');
      emit(ShopRegisterAppErrorGetData());
    });
  }

  void putUpdateProfile({name, phone, email}) {
    emit(ShopUpdateAppLoadingGetData());
    DioHelper.putData(
            url: UPTADE,
            data: {
              'name': name,
              'phone': phone,
              'email': email,
            },
            token: token)
        .then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      // print('message : ${profileModel!.message!}');
      // print('status : ${profileModel!.status}');

      emit(ShopUpdateAppSeccessGetData(profileModel!));
    }).catchError((error) {
      print('update error $error');
      emit(ShopUpdateAppErrorGetData());
    });
  }
}
