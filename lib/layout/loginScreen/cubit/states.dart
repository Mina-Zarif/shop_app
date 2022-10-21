import '../../../models/login_model/login_model.dart';

abstract class ShopLoginStates {}

class AppInitialStates extends ShopLoginStates {}

class LoadingState extends ShopLoginStates {}

class SuccessState extends ShopLoginStates {
  // ignore: non_constant_identifier_names
  final LoginModel;
  SuccessState(this.LoginModel);
}

class ErrorState extends ShopLoginStates {
  final String error;
  ErrorState(this.error);
}

class ChangeObscure extends ShopLoginStates {}

