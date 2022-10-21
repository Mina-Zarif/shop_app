
abstract class ShopRegisterStates {}

class AppRegisterInitialStates extends ShopRegisterStates {}

class LoadingRegisterState extends ShopRegisterStates {
}

class SuccessRegisterState extends ShopRegisterStates {
  final RegisterModel;
  SuccessRegisterState(this.RegisterModel);
}

class ErrorRegisterState extends ShopRegisterStates {

  // final String error;
  // ErrorState(this.error);
}

class ChangeRegisterObscure extends ShopRegisterStates {}

