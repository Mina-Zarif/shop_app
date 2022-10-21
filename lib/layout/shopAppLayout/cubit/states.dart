import 'package:shop_app/models/FavouriteModel/FavouriteModel.dart';

abstract class ShopStates {}

class ShopAppInitialStates extends ShopStates {}

class ShopAppChangeIndexState extends ShopStates {}

class ShopAppLoadingGetData extends ShopStates {}

class ShopHomeAppSeccessGetData extends ShopStates {}

class ShopHomeAppErrorGetData extends ShopStates {}

class ShopCategoriesAppSeccessGetData extends ShopStates {}

class ShopCategoriesAppErrorGetData extends ShopStates {}

class ShopChangeFavoritesAppSeccessGetData extends ShopStates {
  final ChangeFavoriteModel model;

  ShopChangeFavoritesAppSeccessGetData(this.model);
}

class ShopChangeFavoritesAppGetData extends ShopStates {}

class ShopChangeFavoritesAppErrorGetData extends ShopStates {}

class ShopFavoritesAppLoadingGetData extends ShopStates {}

class ShopFavoritesAppSeccessGetData extends ShopStates {}

class ShopFavoritesAppErrorGetData extends ShopStates {}

class ShopProfileAppLoadingGetData extends ShopStates {}

class ShopProfileAppSeccessGetData extends ShopStates {}

class ShopProfileAppErrorGetData extends ShopStates {}

class ShopRegisterAppLoadingGetData extends ShopStates {}

class ShopRegisterAppSeccessGetData extends ShopStates {}

class ShopRegisterAppErrorGetData extends ShopStates {}

class ShopUpdateAppLoadingGetData extends ShopStates {}

class ShopUpdateAppSeccessGetData extends ShopStates {
  // ignore: prefer_typing_uninitialized_variables
  final updateProfile;
  ShopUpdateAppSeccessGetData(this.updateProfile);
}

class ShopUpdateAppErrorGetData extends ShopStates {}
