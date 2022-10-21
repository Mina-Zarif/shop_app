import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/loginScreen/cubit/states.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import '../../../models/login_model/login_model.dart';

import '../../../shared/network/local/endPoint.dart';


// ignore: non_constant_identifier_names
ShopLoginModel? LoginModel;

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(AppInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  bool isShowen = true;

  void changeObscure() {
    isShowen = !isShowen;
    emit(ChangeObscure());
  }

  void userLogin({required email, required password}) {
    emit(LoadingState());

    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      // print(value);
      LoginModel = ShopLoginModel(value.data);
      emit(SuccessState(LoginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorState(error.toString()));
    });
  }

  // void appLogin(BuildContext context) {
  //   emit(LoadingState());
  //   CacheHelper.SaveData(key: 'token', value: LoginModel!.data!.token)
  //       .then((value) {
  //     token = LoginModel!.data!.token;
  //     navigateAndFinish(context, ShopLayout());
  //     // ShopCubit.get(context).currentIndex = 0;
  //   });
  // }
}
