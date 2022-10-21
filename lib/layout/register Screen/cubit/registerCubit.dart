import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/register%20Screen/cubit/registerStates.dart';
import 'package:shop_app/shared/network/local/endPoint.dart';

import '../../../models/profileModel/profileModel.dart';
import '../../../models/registerModel/registerModel.dart';
import '../../../shared/network/remot/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(AppRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  bool isShowen = false;

  void changeObscure() {
    isShowen = !isShowen;
    emit(ChangeRegisterObscure());
  }
  RegisterModel? registerModel;
  void userRegister(
      {required email, required password, required name, required phone}) {
    emit(LoadingRegisterState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data!);
      // print(value.data);
      emit(SuccessRegisterState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegisterState());
    });
  }
}
//
// "name": "mina zarif",
// "phone": "1234567899000",
// "email": "Mina_Zarif@gmail.com",
// "password": "123456",
